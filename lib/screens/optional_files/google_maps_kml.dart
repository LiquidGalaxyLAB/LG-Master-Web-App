// -------------------------------------------- GOOGLE MAPS SCREEN --------------------------------------------
// ---------------------------------------- INTERNAL BROWSER VERSION  -----------------------------------------
// This screen gives information about how to integrates Google Maps on your project opening the map inside the app
// For that, you have to work with KML files
// KML files store geographic data and can be displayed in mapping apps like Google Maps

// !!!!!!!!!!!!!!!
// NOT OPERATIVE YET: some problems with detecting the KML file
// !!!!!!!!!!!!!!!

// ---------------------- HOW TO GET A KML FILE ----------------------
// A KML file is a XML-formatted file used to display geographic data in mapping applications
// To get a KML file, you have to first create a map in Google Maps
// After that, you can export it as a KML file by clicking the three dots menu and selecting “Export to KML/KMZ”
// Make sure you click on "Export as KML". If not, it will export as KMZ and this file is designed to work with KML
// Store the file in the 'kml' folder in the 'assets' folder of the project

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:google_maps_flutter/google_maps_flutter.dart'; // IMPORTANT!! This only works on Android and IOs
// If you work on Windows, this will not work
// In GSoC we work with Android
import 'package:flutter/services.dart'
    show rootBundle; // Used to load asset files like KMLs as strings
import 'package:xml/xml.dart'; // XML parser library to read the KML file

// ---------------------- Google Maps KML screen widget ----------------------
// GoogleMapsKMLScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class GoogleMapsKMLScreen extends StatefulWidget {
  const GoogleMapsKMLScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  State<GoogleMapsKMLScreen> createState() => _GoogleMapsKmlScreenState();
  // This line creates the mutable state associated with GoogleMapsKmlScreen
  // The state object will hold the logic for what the Google Maps screen does
}

// ---------------------- Google Maps KML screen state ----------------------
// This class manages the state (in other words, the behavior) of the Google Maps screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _GoogleMapsKmlScreenState extends State<GoogleMapsKMLScreen> {
  late GoogleMapController _mapController;
  // GoogleMapController allows to control the map (move camera, change zoom, etc.)
  // late means this variable (_mapController) will be initialized later but before it is used

  final Set<Marker> _markers = {};
  // Initializes an empty set of markers
  // The 'Marker' object represents the pins or icons that can be seen on the map
  // This set will hold all the markers from the KML file and display them on the map

  final LatLng _initialPosition = const LatLng(20.0, 20.0);
  // Defines the initial center position of the map when it first loads
  // 'LatLng' holds a geographic coordinate (latitude and longitude)
  // Latitude = 20.0 and Longitude = 20.0 in this case
  // These are just example values, you can choose the values you want

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  void initState() {
    super.initState();
    // Call parent class init method

    _loadKml();
    // Calls the custom method we defined in this file to load KML data
    // This will basically extract placemarks and add them to _markers
    // Further explanation offered in the next lines of code
  }

  // ---------------- Load KML method ----------------
  // The _loadKML method is defined to read and parse the KML file
  Future<void> _loadKml() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect, not to return data

    try {
      // Block used to catch any errors that might occur when loading or parsing the KML file

      final String kmlString = await rootBundle
          .loadString('assets/kml/LG_Master_Web_App_KML_Maps.kml');
      // Loads the KML file (make sure the route to where your KML file is stored is correct)
      // 'await' pauses execution until the file is fully loaded
      // rootBundle.loadString(...) reads a text file from assets (in this case, it reads the KML file)
      // This KML file MUST be included in pubspec.yaml
      // If not, the project will not be able to read it

      final XmlDocument document = XmlDocument.parse(kmlString);
      // Parses the KML content (which is XML) into a structured XmlDocument
      // This allows you to navigate and extract elements from it like a tree of XML nodes

      final placemarks = document.findAllElements('Placemark');
      // Searches the parsed XML for all <Placemark> elements
      // In KML the <Placemark> tag defines map features like points, lines, and polygons
      // This line of code collects them into a list or iterable to process them later

      Set<Marker> markers = {};
      // Temporary empty set to store parsed markers
      // These markers will be created by looping through the placemarks and extracting their coordinates and names

      // ---------------- Loop to obtain the placemarks ----------------
      for (var placemark in placemarks) {
        final nameElement = placemark.getElement('name');
        // Get the 'name' element of the current placemark
        // Basically getting the name of the location

        final coordsElement = placemark
            .findAllElements('coordinates')
            // Finding all 'coordinates' elements inside the current placemark

            .firstWhere(
              (element) => element.value?.trim().isNotEmpty ?? false,
              // firstWhere is used to select the first one that has non-empty text
              // element.value gets the direct text inside the 'coordinates' element
              // ?.trim() removes any surrounding whitespace if the value is not null
              // .isNotEmpty checks if the remaining string is not empty
              // ?? false handles the case where .value is null, returning false if this happens

              orElse: () => XmlElement(XmlName('')),
              // If no element in 'coordinates' is found, it returns an empty XmlElement element
              // This prevents the app from crashing
            );

        if ((coordsElement.value ?? '').trim().isNotEmpty) {
          // If the coordinates have a value (are not an empty element)

          final coordsText = coordsElement.value!.trim();
          // Stores the coordinate string in the 'coordsText' variable
          // .value! forces Dart to treat the value as non-null
          // It turns a nullable variable (String?) into a non-nullable variable (String)
          // This is only safe because we have already ensured it is not null
          // If we skipped that check and it was null our app would crash
          // .trim() removes any surrounding whitespace if the value is not null

          final parts = coordsText.split(',');
          // Splits the coordinates string by commas into a list
          // For example, "100.0,20.0,0.0" turns into ["100.0", "20.0", "0.0"]
          // Coordinates are in "longitude,latitude,altitude" format
          // This means the first two values are longitude and latitude

          if (parts.length >= 2) {
            // Makes sure there are at least two values (longitude and latitude)
            // In this case we do not care about altitude

            final double? lon = double.tryParse(parts[0]); // Longitude
            final double? lat = double.tryParse(parts[1]); // Latitude
            // Parse longitude and latitude from text to double
            // This is necessary because KML gives the coordinates as text and Dart loads it as String
            // Google Maps needs double numbers

            if (lon != null && lat != null) {
              // If both longitude and latitude were successfully parsed (basically if they are not null)

              markers.add(Marker(
                // Adds a new Marker to the 'markers' set

                markerId:
                    MarkerId(nameElement?.value ?? 'marker_${markers.length}'),
                // Sets a unique ID for the marker
                // If the 'name' tag (nameElement) exists, uses that text
                // If not, generates a name like 'marker_0', 'marker_1', etc.

                position: LatLng(lat, lon),
                // Specifies the markers latitude and longitude

                infoWindow: InfoWindow(title: nameElement?.value ?? 'Marker'),
                // Sets the title shown when the user taps on the marker
                // Uses the 'name' tag if it exists
                // Otherwise defaults to 'Marker'
              ));
            }
          }
        }
      }

      // Updates the UI with the new markers
      setState(() {
        // setState() is used to rebuild the UI when the state changes

        _markers.addAll(markers);
        // Adds all the parsed markers from the KML file
      });
    } catch (e) {
      // Handle errors (file not found, XML parsing errors, etc.)

      print('Error loading KML: $e');
      // If an error happens it is printed in the debug console
      // NOT visible to the user, only to the developer
    }
  }

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  @override
  // Override the 'build' method from the State class

  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
          // Top bar of the app, often used for navigation or titles

          title: const Text('Google Maps with KML')
          // Title displayed in the app bar
          ),

      body: GoogleMap(
        // 'body' refers to the main content area of the screen
        // The Google Map widget that displays the map

        initialCameraPosition: CameraPosition(
          // Sets the initial and predefined camera focus

          target: _initialPosition,
          // Uses the center we defined earlier
          // In this case it was Latitude = 20.0 and Longitude = 20.0 in this case

          zoom: 2,
          // Controls the zoom level of the map
          // 1 = entire world
          // 20 = street or building
        ),

        markers: _markers,
        // Displays all markers that were parsed from the KML file earlier and that were stored in _markers

        onMapCreated: (controller) => _mapController = controller,
        // Called when the map is fully created and ready
        // Saves the controller so we can interact with the map later
      ),
    );
  }
}
