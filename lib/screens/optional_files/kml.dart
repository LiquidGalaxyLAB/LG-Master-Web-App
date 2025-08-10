// -------------------------------------------- SEND KMLS SCREEN --------------------------------------------
// ---------------------- HOW TO GET A KML FILE ----------------------
// A KML file is an XML-formatted file used to display geographic data in mapping applications
// To get a KML file, you have to first create a map in Google Maps
// After that, you can export it as a KML file by clicking the three dots menu and selecting “Export to KML/KMZ”
// Make sure you click on "Export as KML". If not, it will export as KMZ and this file is designed to work with KML
// Store the file in the 'kml' folder in the 'assets' folder of the project

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/lg_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class KMLScreen extends StatelessWidget {
  const KMLScreen({super.key});

  /*
  // KML example with random but close points
  final String sampleKml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>KML example file</name>
    <Placemark>
      <name>Location A</name>
      <Point><coordinates>-3.7038,40.4168,0</coordinates></Point>
    </Placemark>
    <Placemark>
      <name>Location B</name>
      <Point><coordinates>-3.7070,40.4175,0</coordinates></Point>
    </Placemark>
    <Placemark>
      <name>Location C</name>
      <Point><coordinates>-3.7055,40.4150,0</coordinates></Point>
    </Placemark>
  </Document>
</kml>
''';
*/

  Future<void> _sendExampleKml(BuildContext context) async {
    final lgService = Provider.of<LgService>(context, listen: false);

    // Make sure there is connection
    final conected = await lgService.connectToLG();
    if (conected != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Could not connect with the Liquid Galaxy')),
      );
      return;
    }

    // Load KML file from assets
    String sampleKml;
    try {
      sampleKml = await rootBundle.loadString('assets/kml/sendKmlExample.kml');
      // This file has to also be loaded on pubspec.yaml or it will not work!!!
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading KML file: $e')),
      );
      return;
    }

    // The KML is shown in the furthest right screen
    final int rightMost = lgService.calculateRightMostScreen(
      lgService.connectionModel.screens,
    );

    // Send KML
    await lgService.execute(
      "echo '${sampleKml.replaceAll("'", "'\\''")}' > /var/www/html/kml/slave_$rightMost.kml",
      'Example KML was sent',
    );

    // Force refresh
    await lgService.cleanLogos();
    await lgService.cleanKML();
    await lgService.cleanBalloonKML();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('The example KML was sent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send a KML to the Liquid Galaxy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'In Liquid Galaxy, the KML files allow to display points of interest, paths, etc., in Google Earth distributed through different screens.\n\n'
              'In order to show a KML, the app sends the KML file content to the Liquid Galaxy directory and forces a refresh to make it appear on the screen\n\n'
              'Tap on the button to send an example with three close POIs (Points Of Interest).',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _sendExampleKml(context),
                child: const Text('Send an example KML'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
