// ----------HOW TO GET A KML FILE----------
// In order to use Google Erath in our Flutter app, first we have to open a KML file in Google Earth Web
// A KML file is a XML-formatted file used to display geographic data in mapping applications
// To get a KML file, you have to first create a map in Google Maps
// After that, you can export it as a KML file by clicking the three dots menu and selecting “Export to KML/KMZ”

// ------------------------------
class LGGoogleEarthService {
  void openKMLInEarthWeb(String kmlUrl) {
    // You will have to replace this URL with your actual public KML file URL
    final kmlUrl = 'https://yourdomain.com/maps/my_map.kml';
    // To open a KML in Google Earth Web you have to use the URL pattern 'https://earth.google.com/web?url=YOUR_KML_URL'
    final earthWebUrl = 'https://earth.google.com/web?url=$kmlUrl';
    // In Flutter, you can use url_launcher to open this URL the browser:
    // await launchUrl(Uri.parse(earthWebUrl));
    print('Open this URL in your browser: $earthWebUrl');
  }

  // We generate a Google Earth Web URL for a given KML file
  // This link can be shared or used everywhere else to open the KML file directly
  String getEarthWebLink(String kmlUrl) {
    return 'https://earth.google.com/web?url=$kmlUrl';
  }

  // The link MUST be accessible by anyone on the Internet, as it must be public for Google Earth to use it
  // This means that Google Earth Web requires the KML file to be accessible without authentication
  Future<bool> isKMLUrlAccessible(String kmlUrl) async {
    try {
      final response = await http.head(Uri.parse(kmlUrl));
      return response.statusCode == 200;  // If it is publicly accessible, we get an 'OK' (200) response
    } catch (e) {
      return false; // If the file does not exist or is private, it returns 'false'
    }
  }

  // -----------OPTIONAL-----------
  // You can also download the KML file if you want to
  // This can be useful to view or analyze the geographic data locally or even to use as a template
  Future<String?> downloadKML(String kmlUrl) async {
    try {
      final response = await http.get(Uri.parse(kmlUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
