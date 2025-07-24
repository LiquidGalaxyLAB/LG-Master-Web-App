// -------------------------------------------- HELP SCREEN --------------------------------------------
// Screen that offers a description of the project, as well as information about the developers and the partners

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:url_launcher/url_launcher.dart'; // Used to open URLs in browser or apps, must also be added on the pubspec.yaml file
// For this to work on Android emulator, add permission to us ethe internet in the Android manifest!!
// Check the AndroidManifest.xml file for more info
// Emulators do not have a browser, try on real phone

// ---------------------- Help Screen widget ----------------------
// HelpScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

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

        title: const Text('Help and about'),
        // Title displayed in the app bar

        backgroundColor: Colors.green,
        // Background color of the app bar
        // In this case is green, but you can choose any color you want
      ),
      body: SingleChildScrollView(
        // 'body' refers to the main content area of the screen
        // Wraps the content in a scrollable container, allowing to scroll vertically if it overflows
        // Useful when the content is really long and does not fit on the screen

        padding: const EdgeInsets.all(20),
        // Adds padding of 20 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: Column(
          // Stacks widgets vertically

          crossAxisAlignment: CrossAxisAlignment.center,
          // Aligns the children horizontally to center

          children: [
            // List of child widgets that will be stacked vertically

            // ------- ICON AND TITLE -------
            const Icon(Icons.help_outline,
                // Icons.help_outline is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a question mark
                // You can choose other icons

                color: Colors.green,
                // Sets the icon color to green
                // You can choose other colors

                size: 70
                // Sets the icon size to 70 px
                // You can choose the size you want
                ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 16 px, you can use any value you want
            // This is just an aesthetic choice

            const Text(
              'Liquid Galaxy Master Web Application',
              // Text that appears on the screen alongside the icon

              style: TextStyle(
                  // Applies custom styling to the text

                  fontSize: 24,
                  // Sets the text size to 24 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.bold
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- PROJECT DESCRIPTION -------
            Container(
              padding: const EdgeInsets.all(16),
              // Adds padding of 16 px to all sides (top, bottom, left, right)
              // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
              // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
              // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              // You can add padding on individual sides, for example:
              // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
              // EdgeInsets.only(left: 8.0, top: 10.0)

              decoration: BoxDecoration(
                // 'decoration' is a property of the Container widget that allows to visually style the container
                // For example, setting borders, gradients, background images, etc

                color: Colors.green.shade50,
                // Color of the background of the container
                // In this case it is a light green but you can choose any color you want

                borderRadius: BorderRadius.circular(12),
                // Rounds the container corners with a 12 px radius
              ),
              child: const Text(
                'This project is part of Google Summer of Code (GSoC) 2025. '
                'The aim of this project is to create a comprehensive code repository and master document to be used as a structured guide for future Liquid Galaxy and GSoC contributors.'
                'This will provide them with a solid idea of where to start, how the code structure should look like, coding mistakes to avoid and how to do it, useful tips, etc.'
                'What you have here is a basic app with the minimal screens and functionalities that your own app should have.'
                "The written guide can be consulted on the project's GitHub repository (link provided at the end of this screen)."
                'This document was be elaborated by coding, tweaking, and reviewing the code of multiple past and actual GSoC projects, as well as finding the common aspects between them to create a structure that future contributors can follow.'
                'The goal is that this project will act as both a coding guide and a proposal reference, making sure that future contributors can achieve their own expectations.',
                // Text displayed on the screen
                // In this case, information about the project and its purpose

                style: TextStyle(
                    // Applies custom styling to the text (to the title in this case)

                    fontSize: 16
                    // Sets the text size to 16 px
                    // As always, this is just an example value
                    ),

                textAlign: TextAlign.center,
                // Aligns the text horizontally to the center of its container
              ),
            ),

            const SizedBox(height: 30),
            // Adds vertical space between the icon and the text
            // This is just an example value of 30 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- PARTNERS AND SUPPORTERS -------
            const Text(
              'Partners and supporters',
              // Text displayed as the title of this section

              style: TextStyle(
                  // Applies custom styling to the text (to the title in this case)

                  fontSize: 18,
                  // Sets the text size to 18 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.w600
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 16 px, you can use any value you want
            // This is just an aesthetic choice

            // ---- Displaying the logos of the partners ----
            Wrap(
              // A wrap is a responsive grid, it puts items in a row and, when it runs out of space, puts them in a new row

              spacing: 16,
              // Horizontal space between items (this is just an example value of 16 px, you can use any value you want)

              runSpacing: 16,
              // Vertical space between rows (this is just an example value of 16 px, you can use any value you want)

              alignment: WrapAlignment.center,
              // Aligns the items in the center

              children: const [
                // The following is the list of logos os the partners used in the project
                // Check if these logos are updated when you work on your project!! They may change with time
                // LogoImage is a widget we created at the end of this file
                // It helps us make this file more efficient, as it is used for every single one of these images

                LogoImage('assets/images/FacensLogo.png'), // Facens logo
                LogoImage(
                    'assets/images/FlutterLleidaLogo.jpg'), // Flutter Lleida logo
                LogoImage('assets/images/FlutterLogo.png'), // Flutter logo
                LogoImage(
                    'assets/images/GDGlleidaLogo.png'), // Google Developer Groups Lleida logo
                LogoImage(
                    'assets/images/GsocLogo.png'), // Google Summer of Code logo
                LogoImage(
                    'assets/images/LaboratorisLogo.png'), // Laboratoris TIC logo
                LogoImage(
                    'assets/images/LiquidGalaxyEUlogo.png'), // Liquid Galaxy EU logo
                LogoImage(
                    'assets/images/LiquidGalaxyLabLogo.png'), // Liquid Galaxy lab logo
                LogoImage(
                    'assets/images/LiquidGalaxyLogo.png'), // Liquid Galaxy logo
                LogoImage(
                    'assets/images/ParcAgroLleidaLogo.jpg'), // Agrobiotech Lleida Parc logo
                LogoImage(
                    'assets/images/ParcLleidaLogo.jpg'), // Scientific and Technologic Lleida Park logo
              ],
            ),

            const SizedBox(height: 30),
            // Adds vertical space between the icon and the text
            // This is just an example value of 30 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- EXTERNAL LINKS -------
            const Text(
              'Learn more!',
              // Text displayed on the screen

              style: TextStyle(
                  // Applies custom styling to the text (to the title in this case)

                  fontSize: 18,
                  // Sets the text size to 18 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.w600
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 10),
            // Adds vertical space between the icon and the text
            // This is just an example value of 10 px, you can use any value you want
            // This is just an aesthetic choice

            // ---- Liquid Galaxy website ----
            LinkButton(
              label: 'Visit the Liquid Galaxy website',
              // Text displayed on the button

              url: 'https://www.liquidgalaxy.eu/',
              // External URL associated to the button

              icon: Icons.public,
              // Icon displayed on the button
              // You can choose any icon you want
              // In this case it looks like a globe
            ),

            // ---- GSoC website ----
            LinkButton(
              label: 'Learn more about GSoC 2025',
              // Text displayed on the button

              url:
                  'https://www.liquidgalaxy.eu/2024/11/unique-post-for-gsoc-2025-at-liquid.html',
              // External URL associated to the button

              icon: Icons.book,
              // Icon displayed on the button
              // You can choose any icon you want
              // In this case it looks like a book
            ),

            // ---- Liquid Galaxy GitHub ----
            LinkButton(
              label: 'Explore the Liquid Galaxy GitHub',
              // Text displayed on the button

              url: 'https://github.com/LiquidGalaxyLAB',
              // External URL associated to the button

              icon: Icons.code,
              // Icon displayed on the button
              // You can choose any icon you want
              // In this case it looks like a link
            ),

            const SizedBox(height: 30),
            // Adds vertical space between the icon and the text
            // This is just an example value of 30 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- AUTHOR AND MENTORS -------
            const Text(
              'Project team',
              // Text displayed on the screen

              style: TextStyle(
                  // Applies custom styling to the text (to the title in this case)

                  fontSize: 18,
                  // Sets the text size to 18 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.w600
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 10),
            // Adds vertical space between the icon and the text
            // This is just an example value of 10 px, you can use any value you want
            // This is just an aesthetic choice

            const Text(
              // Text displayed on the screen with atual information on the project team

              'Contributor: Lucía Fernández Giner\n'
              // Contributor
              // \n adds a new line for readability reasons

              'Mentor: Claudia Mihaela Diosan\n'
              // Mentor
              // \n adds a new line for readability reasons

              'Organization admin: Andreu Ibáñez\n'
              // Organization admin
              // \n adds a new line for readability reasons

              'Support by: Liquid Galaxy Lab - Lleida\n'
              // Information on the LG lab

              'Thanks to my mentor and to the team of the Liquid Galaxy LAB Lleida for all their help.\n'
              'Headquarters of the Liquid Galaxy project: Alba, Paula, Josep, Jordi, Oriol, Sharon, Alejandro, Marc, and admin Andreu, for their continuous support on my project.\n'
              'More info in www.liquidgalaxy.eu',

              style: TextStyle(
                  // Applies custom styling to the text (to the title in this case)

                  fontSize: 16
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- PROJECT REPOSITORY INFO -------
            const Text(
              'Project repository',
              style: TextStyle(
                  // Applies custom styling to the text (to the title in this case)

                  fontSize: 18,
                  // Sets the text size to 18 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.w600
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)
                  ),

              textAlign: TextAlign.center,
              // Aligns the text horizontally to the center of its container
            ),

            const SizedBox(height: 10),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            Row(
              // Creates a horizontal layout widget to arrange children in a row

              mainAxisAlignment: MainAxisAlignment.center,
              // Puts them in the center vertically

              children: [
                // List of child widgets that will be stacked vertically

                SocialIcon(
                  // Reusable button widget that displays an icon image that can be clicked on

                  assetPath: 'assets/icons/github_logo.png',
                  // GitHub logo

                  url: 'https://github.com/LiquidGalaxyLAB/LG-Master-Web-App/',
                  // GitHub URL of the project
                ),
              ],
            ),

            const SizedBox(height: 30),
            // Adds vertical space between the icon and the text
            // This is just an example value of 30 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- GOING BACK BUTTON -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              icon: const Icon(Icons.arrow_back),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a arrow pointing to the left

              label: const Text('Back'),
              // Text shown on the button

              style: ElevatedButton.styleFrom(
                // Customizes the appeareance of the button

                backgroundColor: Colors.green,
                // Sets button background color to green
                // You can choose a different color if you want

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want

                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                // Combine both horizontal and vertical padding
                // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
                // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
                // If you wanted to add padding on top, bottom, left and right you would use EdgeInsets.all(8.0);
                // You can add also padding on individual sides, for example:
                // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
                // EdgeInsets.only(left: 8.0, top: 10.0)
              ),
              onPressed: () => Navigator.pop(context),
              // Assigns the function that should run when the button is pressed
              // In this case, Navigator.pop(context) closes the current screen and go back to the previous one
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- LogoImage class ----------------------
// This defines a reusable widget that takes an image path and displays said image
// In this code, we use it to display all the logos in the wrap
class LogoImage extends StatelessWidget {
  final String imagePath;
  // imagePath is the image file path in this case, we use it to load the image from assets
  // An example of path in this code would be 'assets/images/FacensLogo.png'

  const LogoImage(this.imagePath, {super.key});
  // This line defines how to create an object of the LogoImage class
  // this.path assigns the path provided to the 'path' variable
  // For example, in LogoImage('assets/images/FacensLogo.png'), the value of the 'path' variable would be 'assets/images/FacensLogo.png'

  @override
  // Override the 'build' method from the State class

  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      // Loads the image from assets using the given path

      height: 50,
      // Sets the image width to 50 px (this is just an example value, you can use any value you want)

      width: 50,
      // Sets the image height to 50 px (this is just an example value, you can use any value you want)

      fit: BoxFit.contain,
      // Makes sure the image fits without being cropped or stretched, scaling if necessary
    );
  }
}

// ---------------------- LinkButton class ----------------------
class LinkButton extends StatelessWidget {
  final String label;
  // Variable to store the text of the button

  final String url;
  // Variable to store the URL that will be opened when the button is pressed

  final IconData icon;
  // Variable to store the icon to display alongside the label

  const LinkButton({
    super.key,
    // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
    // This helps Flutter identify and track this widget when rebuilding the screen
    // It basically passes an optional key to the parent widget for identification during widget rebuilds

    required this.label,
    // 'required' makes that the label value is always provided

    required this.url,
    // 'required' makes that the url value is always provided

    required this.icon,
    // 'required' makes that the icon value is always provided
  });

  void _launchURL(String url) async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    final uri = Uri.parse(url);
    // This line parses the URL string into a Uri object, which is required by launchUrl
    // 'Uri' is a built-in Dart class that represents a standard way to identify URLs
    // Uri.parse() is a method that takes a string (in this case, mapsWebUrl) and converts it into a Uri object
    // The Uri object that we get as a result of this parsing that can be used safely with other APIs

    // ------ Checking if the URL can be opened ------
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
    }
  }

  @override
  // Override the 'build' method from the State class

  // ------ Build the screen interface ------
  Widget build(BuildContext context) {
    return TextButton.icon(
      // Text button with an icon

      onPressed: () => _launchURL(url),
      // When the button is pressed, it opens an external browser and displays the URL that was provided

      icon: Icon(icon,
          // Displays the icon of the button

          color: Colors.green
          // Displays the icon in a green color
          // You can choose any color you want
          ),

      label: Text(
        // Displays the text of the icon

        label,
        // Shows the label (the text) that was provided

        style: const TextStyle(
            // Applies custom styling to the text (to the title in this case)

            fontSize: 16
            // Sets the text size to 16 px
            // As always, this is just an example value
            ),

        textAlign: TextAlign.center,
        // Aligns the text horizontally to the center of its container
      ),
    );
  }
}

// ---------------------- SocialIcon class ----------------------
class SocialIcon extends StatelessWidget {
  final String assetPath;
  // Variable to store the path where the asset (the icon) is located

  final String url;
  // Variable to store the URL that will be opened when the button is pressed

  const SocialIcon({
    super.key,
    // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
    // This helps Flutter identify and track this widget when rebuilding the screen
    // It basically passes an optional key to the parent widget for identification during widget rebuilds

    required this.assetPath,
    // 'required' makes that the asset path value is always provided

    required this.url,
    // 'required' makes that the url value is always provided
  });

  void _launchURL(String url) async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    final uri = Uri.parse(url);
    // This line parses the URL string into a Uri object, which is required by launchUrl
    // 'Uri' is a built-in Dart class that represents a standard way to identify URLs
    // Uri.parse() is a method that takes a string (in this case, mapsWebUrl) and converts it into a Uri object
    // The Uri object that we get as a result of this parsing that can be used safely with other APIs

    // ------ Checking if the URL can be opened ------
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
    }
  }

  @override
  // Override the 'build' method from the State class

  // ------ Build the screen interface ------
  Widget build(BuildContext context) {
    return IconButton(
      // Clickable button

      icon:
          // Displays the icon of the button

          Image.asset(assetPath,
              // Sets the icon of the button to an image loaded from local assets (using the value of assetPath)

              width: 32,
              // Sets the icon width to 32 px (this is just an example value, you can use any value you want)

              height: 32
              // Sets the icon height to 32 px (this is just an example value, you can use any value you want)
              ),

      onPressed: () => _launchURL(url),
      // When the button is pressed, it opens an external browser and displays the URL that was provided

      tooltip: url,
      // A tooltip is a small popup text that shows when the user hovers or long-presses the button
      // In this case, it shows the URL
    );
  }
}
