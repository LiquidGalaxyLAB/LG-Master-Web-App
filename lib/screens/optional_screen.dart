// -------------------------------------------- OPTIONAL SCREEN --------------------------------------------
// In this screen you will be able to explore some optional implementations for your project
// You have the opportunity of incorporating AI, Google Maps and Nodejs

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'optional_files/google_maps.dart'; // Imports the screen related to the Google Maps external browser explanation and example
import 'optional_files/google_maps_kml.dart'; // Imports the screen related to the Google Maps internal browser explanation and example
import 'optional_files/nodejs.dart'; // Imports the screen related to the Nodejs explanation and example
import 'optional_files/ai.dart'; // Imports the screen related to the AI explanation and example
import 'optional_files/qr.dart'; // Imports the screen related to the QR code scanning explanation and example

// ---------------------- Optional screen widget ----------------------
// OptionalScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class OptionalScreen extends StatelessWidget {
  const OptionalScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('Optional features'),
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

        child: ListView(
          // Widget that displays its children linearly
          // It is vertically by default but can also be horizontally
          // In this case, it is used to display the different optional features

          children: [
            // List of child widgets that will be stacked vertically

            // ------- GOOGLE MAPS EXTERNAL BROWSER -------
            _FeatureCard(
              // _FeatureCard is a custom widget we created at the end of this file
              // It is reusable

              title: 'Open Google Maps with an external browser',
              // Title of the optional feature

              description:
                  'Learn how to integrate Google Maps on your project using a public URL',
              // Description of the optional feature

              onTap: () => Navigator.push(
                // 'onTap' defines what happens when the user taps the option (the button)
                // In this case, it navigates to the screen that has info on Google Maps
                // Navigator.push adds a new screen (it transitions to a new page)

                context,
                // 'context' represents the location of the current widget in the widget tree
                // Flutter uses it to know where to place the new screen in the navigation hierarchy

                MaterialPageRoute(builder: (_) => const GoogleMapsScreen()),
                // MaterialPageRoute is used to create a page transition animation
                // GoogleMapsScreen is the class associated to the screen with info about Google Maps
              ),
            ),

            // ------- GOOGLE MAPS INTERNAL BROWSER -------
            _FeatureCard(
              // _FeatureCard is a custom widget we created at the end of this file
              // It is reusable

              title: 'Open Google Maps in your own application',
              // Title of the optional feature

              description:
                  'Learn how to integrate Google Maps on your project using a public KML file',
              // Description of the optional feature

              onTap: () => Navigator.push(
                // 'onTap' defines what happens when the user taps the option (the button)
                // In this case, it navigates to the screen that has info on Google Maps
                // Navigator.push adds a new screen (it transitions to a new page)

                context,
                // 'context' represents the location of the current widget in the widget tree
                // Flutter uses it to know where to place the new screen in the navigation hierarchy

                MaterialPageRoute(builder: (_) => const GoogleMapsKMLScreen()),
                // MaterialPageRoute is used to create a page transition animation
                // GoogleMapsScreen is the class associated to the screen with info about Google Maps
              ),
            ),

            // ------- NODE.JS -------
            _FeatureCard(
              // _FeatureCard is a custom widget we created at the end of this file
              // It is reusable

              title: 'Using a Node.js server',
              // Title of the optional feature

              description:
                  'Create backend services for your project using a Node.js server',
              // Description of the optional feature

              onTap: () => Navigator.push(
                // 'onTap' defines what happens when the user taps the option (the button)
                // In this case, it navigates to the screen that has info on Nodejs
                // Navigator.push adds a new screen (it transitions to a new page)

                context,
                // 'context' represents the location of the current widget in the widget tree
                // Flutter uses it to know where to place the new screen in the navigation hierarchy

                MaterialPageRoute(builder: (_) => const NodeJsScreen()),
                // MaterialPageRoute is used to create a page transition animation
                // NodeJsScreen is the class associated to the screen with info about Nodejs
              ),
            ),

            // ------- ARTIFICIAL INTELLIGENCE -------
            _FeatureCard(
              // _FeatureCard is a custom widget we created at the end of this file
              // It is reusable

              title: 'Incorporating Artificial Intelligence',
              // Title of the optional feature

              description:
                  'Add AI features to your project with pre-trained models or APIs',
              // Description of the optional feature

              onTap: () => Navigator.push(
                // 'onTap' defines what happens when the user taps the option (the button)
                // In this case, it navigates to the screen that has info on AI
                // Navigator.push adds a new screen (it transitions to a new page)

                context,
                // 'context' represents the location of the current widget in the widget tree
                // Flutter uses it to know where to place the new screen in the navigation hierarchy

                MaterialPageRoute(builder: (_) => const AIScreen()),
                // MaterialPageRoute is used to create a page transition animation
                // AIScreen is the class associated to the screen with info about AI
              ),
            ),

            // ------- QR CODE -------
            _FeatureCard(
              // _FeatureCard is a custom widget we created at the end of this file
              // It is reusable

              title: 'Scanning a QR code',
              // Title of the optional feature

              description: 'Use your phone camera to scan a QR code',
              // Description of the optional feature

              onTap: () => Navigator.push(
                // 'onTap' defines what happens when the user taps the option (the button)
                // In this case, it navigates to the screen that lets the user scan a QR code
                // Navigator.push adds a new screen (it transitions to a new page)

                context,
                // 'context' represents the location of the current widget in the widget tree
                // Flutter uses it to know where to place the new screen in the navigation hierarchy

                MaterialPageRoute(builder: (_) => const QRScreen()),
                // MaterialPageRoute is used to create a page transition animation
                // AIScreen is the class associated to the screen with info about the QR code
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Reusable widget ----------------------
// _FeatureCard is a custom stateless widget that is used to display the different optional features for the project
// This is a reusable widget that we created to make the code more efficient

class _FeatureCard extends StatelessWidget {
  // It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
  // This means the content will not change after it is built
  // The underscore (_) makes the class PRIVATE to the file it is defined in
  // This is useful when the widget is only used in one file, but it is not mandatory to make it private

  final String title;
  // Variable called 'title' used to define the text that will appear as the title of the option

  final String description;
  // Variable called 'description' used to define the text that will appear as the description of the option

  final VoidCallback? onTap;
  // Declares a VoidCallback (a function that returns nothing) to define what should happen when the button is tapped
  // We use a function that returns nothing because when we are just triggering an action (navigating to another screen, showing a dialog,
  // printing something to the console, etc) these actions DO NOT return any value and ONLY need to be executed when the button is tapped
  // '?' in this case means that onTap can have two options here, either null or a function that returns nothing
  // In this case is 'VoidCallback?' and not 'VoidCallback' because we want the onTap parameter to be optional
  // This means that the widget can still work even if no tap handler is provided
  // This is useful when creating reusable UI components that do not always need interaction

  const _FeatureCard({
    // Constructor fo the widget, allows to pass values to the label, icon, color and onTap parameters
    // 'required' makes sure the values MUST be provided in order to use _HomeButton

    required this.title,
    // It is mandatory that the 'title' value is provided

    required this.description,
    // It is mandatory that the 'description' value is provided

    this.onTap,
    // Not mandatory, it means that if an onTap function is provided, it will be stored
  });

  @override
  // Tells Dart that we are overriding the build method of Stateless widget

  Widget build(BuildContext context) {
    return Card(
      // Card is a widget that creates a container

      margin: const EdgeInsets.only(bottom: 20),
      // Adds space around each container
      // The difference with padding is that 'margin' adds the space OUTSIDE the widget while padding adds it INSIDE
      // In this case, it adds 20 px under (bottom) the container
      // If you wanted to add margin space on top and bottom you would use EdgeInsets.symmetric(vertical: 20.0);
      // If you wanted to add margin space on left and right you would use EdgeInsets.symmetric(horizontal: 20.0);
      // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      // You can add margin on individual sides, for example:
      // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
      // EdgeInsets.only(left: 8.0, top: 10.0)
      // If you wanted to add margin space on top, bottom, left and right you would use EdgeInsets.all(20.0);

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // Rounds the container corners with a 12 px radius

      elevation: 4,
      // Adds a shadow to make the button look raised
      // It has to be a double
      // 0 is no shadow, you can set any positive number but above 24 it usually doe snot have much visual effect
      // Higher numbers mean a bigger, softer shadow, making the button look more lifted above the surface
      // Lower numbers mean a smaller, sharper shadow, making the button appear closer to the background

      child: InkWell(
        // InkWell is a widget that adds a touchable area with built-in animations
        // It makes the card respond visually to taps (ripple effect)
        // The ripple effect is a visual animation that indicates the user the widget has been tapped

        borderRadius: BorderRadius.circular(12),
        // Applies rounded corners to the ripple effect so it matches the container shape
        // Without this, the ripple effect might overflow the rounded corners of the Card
        // In this case, it uses a radius of 12 px

        onTap: onTap,
        // Assigns the function that should run when the Inkwell is tapped, which is passed to the widget as 'onTap'
        // If 'onTap' is null, it will not do anything

        child: Padding(
          // Padding is used to add space around the button

          padding: const EdgeInsets.all(16),
          // Adds padding of 16 px to all sides (top, bottom, left, right)
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

              // ---- Text correspondant to the TITLE ----
              Text(title,
                  style: const TextStyle(
                      // Applies custom styling to the text (to the title in this case)

                      fontSize: 20,
                      // Sets the text size to 20 px
                      // As always, this is just an example value

                      fontWeight: FontWeight.bold)),
              // Makes the text bold by applying a heavier font weight
              // You can also use values like FontWeight.w600 or just w600
              // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
              // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)

              const SizedBox(height: 10),
              // Adds vertical space between the title and the description
              // This is just an example value of 10 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- Text correspondant to the DESCRIPTION ----
              Text(description,
                  style: const TextStyle(
                      // Applies custom styling to the text (to the title in this case)

                      fontSize: 16)
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
