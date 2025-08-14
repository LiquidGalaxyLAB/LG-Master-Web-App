// -------------------------------------------- SEND KMLS SCREEN --------------------------------------------
// ---------------------- HOW TO GET A KML FILE ----------------------
// A KML file is an XML-formatted file used to display geographic data in mapping applications
// To get a KML file, you have to first create a map in Google Maps
// After that, you can export it as a KML file by clicking the three dots menu and selecting “Export to KML/KMZ”
// Make sure you click on "Export as KML". If not, it will export as KMZ and this file is designed to work with KML
// Store the file in the 'kml' folder in the 'assets' folder of the project

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)
import '../../services/lg_service.dart'; // Imports the LG service screen, which handles the logic to connect to the Liquid Galaxy screen
import 'package:flutter/services.dart'
    show
        rootBundle; // Imports the library services.dart (which contains tools to interact with platform services)
// show rootBundle specifies that we only import that tool, NOT the whole library

// ---------------------- KML Screen widget ----------------------
// KMLScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class KMLScreen extends StatelessWidget {
  const KMLScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  /*
  // KML example with random but close points
  // This is just an example of what the inside of a KML file looks like

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

  // ------------ sendExampleKml() ------------
  // Used for sending an example KML file to the Liquid Galaxy

  Future<void> _sendExampleKml(BuildContext context) async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (like updating text fields), not to return data
    // It requires the parameter "context" so that the method can find the LgService instance

    final lgService = Provider.of<LgService>(context, listen: false);
    // Provider.of<LgService> searches for an instance of LgService
    // "context" is used to know where to look for this instance
    // listen: false indicates that this service object is just needed right now, so there's no need to listen for rebuilds
    // The result of this operation is stored in the "lgService" variable

    final connected = await lgService.connectToLG();
    // Calls the connectToLG() method to establish a connection with the Liquid Galaxy
    // Stores the result of this call in the "connected" variable

    if (connected != true) {
      // If connected = false, this means that the connection could not be established

      ScaffoldMessenger.of(context).showSnackBar(
        // Scaffold is a basic page layout that creates an structure for the screen
        // Shows a temporary message (a SnackBar) at the bottom of the screen

        const SnackBar(
            content: Text('Could not connect with the Liquid Galaxy')),
        // In this case, it is a message to inform the user that the connection with the Liquid Galaxy was not established
      );
      return;
      // Since the connection could not be established, we exit the sendExampleKml() method
    }

    String sampleKml;
    // Creates a variable called "sampleKml" that will hold the contents of the KML file we want to send

    try {
      // try block used to catch any exceptions that may occur

      sampleKml = await rootBundle.loadString('assets/kml/sendKmlExample.kml');
      // loadString() is a method used to load the content of a file as a String
      // In this case, it reads the "sendKmlExample.kml" file, which is inside the "kml" folder (inside the "assets" folder)
      // This file has to also be loaded on pubspec.yaml or it will not work!!!
      // rootBundle provides access to the asset path
      // await pauses the method until the full file is read
      // The result is stored in the "sampleKml" variable
    } catch (e) {
      // Catches any errors thrown during the try block

      ScaffoldMessenger.of(context).showSnackBar(
        // Scaffold is a basic page layout that creates an structure for the screen
        // Shows a temporary message (a SnackBar) at the bottom of the screen

        SnackBar(content: Text('There was an error loading the KML file: $e')),
        // In this case, it is a message to inform the user that there was an error loading the KML file
      );
      return;
      // Since there was an error during the execution, exits the method
    }

    await lgService.uploadKml(sampleKml, 'example.kml');
    // Calls the uploadKml() method from the lg_service.dart file
    // In this case, sampleKml is the content we send and "example.kml" is the name we give to this file we are sending
    // await pauses everything until this method is complete

    await Future.delayed(const Duration(seconds: 1));
    // Waits 1 second to allow the system to upload the KML before continuing
    // Future.delayed creates a Future (a value that will be available at some point in the future) that completes after a specified delay
    // const Duration(seconds: 1) specifies the length of that delay
    // 'await' pauses execution until the delay is over

    lgService.forceRefresh(1);
    // Calls the forceRefresh() method from the lg_service.dart file
    // In this case, it refreshes the main node (screen = 1), which is where we sent the KML file

    await lgService.flyTo(
      '<LookAt><longitude>-72.5452621</longitude><latitude>-13.1631988</latitude><altitude>0</altitude><heading>0</heading><tilt>45</tilt><range>2000</range><altitudeMode>relativeToGround</altitudeMode></LookAt>',
    );
    // Calls the flyTo() method from the lg_service.dart file
    // In this case it flies to the coordinates that were inside the example KML file I had, just to show better the POIs
    // 'await' pauses execution until the method execution is complete

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      const SnackBar(content: Text('The example KML was sent!')),
      // In this case, it is a message to inform the user that the KML file was sent
    );
  }

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the build() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
          // Top bar of the app, often used for navigation or titles

          title: const Text('Send a KML file to the Liquid Galaxy')
          // Title displayed in the app bar
          ),

      body: Padding(
        // 'body' refers to the main content area of the screen
        // Padding is used to add space around the button

        padding: const EdgeInsets.all(16.0),
        // Adds padding of 16 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 16.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 16.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: Column(
          // Stacks widgets vertically

          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment aligns the children of the COLUMN horizontally
          // .start aligns them to the left side (start)

          children: [
            // List of child widgets that will be stacked vertically (in columns)

            // ---- TITLE ----
            const Text(
              'Send a KML file to the Liquid Galaxy rig',
              // Text displayed on the screen

              style: TextStyle(
                  // Applies custom styling to the text

                  fontSize: 20,
                  // Sets the text size to 20 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.bold),
              // Makes the text bold by applying a heavier font weight
              // You can also use values like FontWeight.w600 or just w600
              // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
              // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the title and the explanation
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ---- EXPLANATION ----
            const Text(
              'In Liquid Galaxy, the KML files allow to display points of interest, paths, etc., in Google Earth distributed through different screens.\n\n'
              'In order to show a KML, the app sends the KML file content to the Liquid Galaxy directory and forces a refresh to make it appear on the screen\n\n'
              'Tap on the button to send an example with three close POIs (Points Of Interest).',
              // Text displayed on the screen

              style: TextStyle(
                  // Applies custom styling to the text

                  fontSize: 16
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the explanation and the KML
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- Button to send the KML -------
            Center(
              // Centers all the widgets vertically and horizontally

              child: ElevatedButton(
                // Creates a button

                onPressed: () => _sendExampleKml(context),
                // This line defines what happens when the user presses the button
                // In this case, calls the method we defined earlier to send a KML example

                child: const Text('Send an example KML'),
                // Text shown on the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
