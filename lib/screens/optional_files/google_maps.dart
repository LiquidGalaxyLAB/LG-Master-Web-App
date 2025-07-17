// -------------------------------------------- GOOGLE MAPS SCREEN --------------------------------------------
// ----------------------------------------- EXTERNAL BROWSER VERSION  ----------------------------------------
// This screen gives information about how to integrates Google Maps on your project opening the map with an external browser
// For that, you have to create a map in Google Maps and get a public URL to share it

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:url_launcher/url_launcher.dart'; // Used to open URLs in browser or apps, must also be added on the pubspec.yaml file
// For this to work on Android emulator, add permission to us ethe internet in the Android manifest!!
// Check the AndroidManifest.xml file for more info
// Emulators do not have a browser, try on real phone

// ---------------------- Google Maps Screen widget ----------------------
// GoogleMapsScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  final String mapsUrl =
      'https://www.google.com/maps/d/viewer?mid=1_n73uHh2o_GhqjYBGkhaFzHW2zNJQ10&usp';
  // This is the public URL to your public Google Maps
  // In this case I created a sample map with the 7 wonders of the modern world
  // Then I clicked share and got the public link to share the map
  // You have to replace this with your actual publicly accessible URL
  // IMPORTANT!!!! This URL must be public to work
  // IMPORTANT!! It will NOT work if it has the word 'edit'
  // The structure of the URL should be this one:
  // https://www.google.com/maps/d/viewer?mid=YOUR_MAP_ID
  // This also means you have to be careful so that this map does NOT contain any sensitive information (for example, your address)

  // ---------------------- Open Google Maps method ----------------------
  Future<void> _openGoogleMaps() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    final Uri uri = Uri.parse(mapsUrl);
    // This line parses the URL string into a Uri object, which is required by launchUrl
    // 'Uri' is a built-in Dart class that represents a standard way to identify URLs
    // Uri.parse() is a method that takes a string (in this case, mapsWebUrl) and converts it into a Uri object
    // The Uri object that we get as a result of this parsing that can be used safely with other APIs

    // ------- Checking if the URL can be opened -------
    if (await canLaunchUrl(uri)) {
      // 'await' pauses execution, it is used in asynchronous functions
      // This is because these functions takes some time to complete and we need to wait for its result
      // 'canLaunchUrl(uri)' checks if the device is capable of launching the specified Uri

      await launchUrl(uri, mode: LaunchMode.externalApplication);
      // If the device is capable of launching the Uri (opening the URL, in other words), this line is executed
      // 'launchUrl()' opens the URL
      // 'uri' is the Uri object containing the web address to be opened
      // LaunchMode.externalApplication tells Flutter to open the URL using an external application rather than inside the app itself
      // This application can be, for example, a web browser or the Google Maps app
    } else {
      // If the device is NOT capable of opening the URL, this line is executed

      debugPrint('Could not launch $mapsUrl');
      // It prints an error to the console for debugging, specifying the URL used
      // This message is NOT shown to the user, is just for debugging purposes
    }
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

        title: const Text('Google Maps integration example'),
        // Title displayed in the app bar
      ),

      body: Padding(
        // 'body' refers to the main content area of the screen
        // Padding is used to add space around the button

        padding: const EdgeInsets.all(20.0),
        // Adds padding of 20 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
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
              'Opening a Google Maps map using a browser',
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
            Text(
              'This is an example on how an integration of Google Maps would look and work in your app. For that, we will be using the following map URL as an example:',
              // Text displayed on the screen

              style: const TextStyle(
                  // Applies custom styling to the text

                  fontSize: 16
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),
            ),

            const SizedBox(height: 10),
            // Adds vertical space between the explanation and the KML
            // This is just an example value of 10 px, you can use any value you want
            // This is just an aesthetic choice

            // ---- KML ----
            Text(
              'Public map URL:\n$mapsUrl',
              // Text displayed on the screen
              // In this case, it displays the KML file URL to the user so it can be easily seen without the need to enter this file
              // It is NOT mandatory to display it, in this case is just for explanation purposes

              style: const TextStyle(
                  // Applies custom styling to the text

                  fontSize: 16
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the KML and the clarification
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ---- KML CLARIFICATION ----
            Text(
              '(It is NOT mandatory that you display the URL. In this case is just so you can see it easily without entering the file)',
              // Text displayed on the screen

              style: const TextStyle(
                  // Applies custom styling to the text

                  fontSize: 16
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the KML clarification and the button
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- Button to open Google Maps -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              onPressed: _openGoogleMaps,
              // Assigns the function that should run when the button is pressed
              // In this case is the _openGoogleMapsWeb method we created
              // This means that, when the button is pressed, the app will open Google Maps with the KML we provided

              icon: const Icon(Icons.public),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.public is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a globe

              label: const Text('Open in Google Maps'),
              // 'label' is a parameter that sets the text shown on the button
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the button and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            const Text(
              // Informational text explaining what happens when the button is pressed
              'When you press the button, the map will be open in your browser using Google Maps web',
            ),
          ],
        ),
      ),
    );
  }
}
