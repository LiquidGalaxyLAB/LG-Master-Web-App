// -------------------------------------------- SPLASH SCREEN --------------------------------------------
// A splash screen is typically a welcome screen that appears when we open an app
// In this case, it will display the logos of Liquid Galaxy and your project
// It will also display other logos related to Liquid Galaxy and to any tools you have used on your project
// The logos displayed in this project are the basic and mandatory ones

// ---------------------- Import packages ----------------------
import 'dart:async'; // Imports the Dart asynchronous tools needed for Timer
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'main_screen.dart'; // Imports the main screen file so we can navigate to it after the logos disappear

// ---------------------- Splash screen widget ----------------------
// SplashScreen class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<SplashScreen> createState() => _SplashScreenState();
  // This line creates the mutable state associated with SplashScreen
  // The state object will hold the logic for what the splash screen does
}

// ---------------------- Splash screen state ----------------------
// This class manages the state (in other words, the behavior) of the splash screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // initState() is a method that runs once when the screen first loads or the widget is first created
    // It acts as a setup function, and that is why is only run once
    // Once the setup is done there's no need to set up everything again (unless the widget is removed and added back)

    super.initState();
    // super.initState() calls the default setup behavior from the parent class (in this case, the State class from Flutter)
    // It basically indicates Flutter to set up its own things first, and then we'll add our own things later

    Timer(const Duration(seconds: 4), () {
      // Navigate to MainScreen after 4 seconds
      // After 4 seconds, it navigates to the main screen and replaces the splash screen, which means users cannot go back to the Splash screen

      // This is just an example value, you can put the time you want
      // However, keep in mind that this is a splash screen, so do not put a value that is too high
      // Just keep in mind that the value has to be an int (1, 2, 3, 4, etc)!!
      // It CANNOT be a float (1.2, 2.6, 3.1, 4.8, etc)
      // If you want a delay like, for example, 2.5 seconds, you can convert it to milliseconds the following way:
      // Timer(const Duration(milliseconds: 2500), () {});

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(
          // MaterialPageRoute is like a page transition in a Material Design style
          // It is used to build the main screen widget

          builder: (_) => const MainScreen()));
    });
  }

  // ---------------------- BuildContext widget ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      backgroundColor: Colors.white,
      // Background color of splash screen, in this example is set to white
      // You can choose any color you want, but white usually fits better because of the background of some logos

      body: Center(
        // 'body' refers to the main content area of the screen
        // 'Center' places everything in the middle of the screen
        // This widget stacks its children vertically and centers them

        child: Column(
          // Stacks widgets vertically

          mainAxisAlignment:
              MainAxisAlignment.center, // Puts them in the center vertically
          children: [
            Hero(
              // The Hero widget creates a shared element transition
              // This is a visual effect where a widget (in this case, a logo) seems to fly from one screen to the next
              // When the user navigates between those two screens (in this case using Navigator.push) Flutter automatically animates the transition

              tag: 'logo',
              // For Hero to work, both widgets must have the same tag
              // If you check the main_screen.dart in this project, you will see the tag is the same
              // You can name the tag as you want, just make sure the name is the same in both widgets and that it is unique!
              // Both widgets must also be in different screens (Hero is meant for transitions, not in-place animations)
              // Both widgets must also have the same type and structure (for example, both being Image.asset) so Flutter can morph them correctly

              child: Image.asset(
                // Image.asset loads an image from the project's assets folder
                // It should be located in the 'images' folder inside the 'assets' folder
                // It should also be added in the pubspec.yaml file, check that file to see how

                'assets/images/LGMasterWebAppLogo.png', // Update this line with the path of your own project logo
                width:
                    120, // Width of the image (this is just an example value of 120 px, you can use any value you want)
                height:
                    120, // Height of the image (this is just an example value of 120 px, you can use any value you want)
              ),
            ),

            const SizedBox(height: 30),
            // Adds vertical space between the icon and the text
            // This is just an example value of 30 px, you can use any value you want
            // This is just an aesthetic choice, since it separates the logo of the projects from the other logos
            // You can add the logos the way you prefer as long as all of them are visible and easy to recognize

            Wrap(
              // A wrap is a responsive grid, it puts items in a row and, when it runs out of space, puts them in a new row
              alignment: WrapAlignment.center, // Aligns the items in the center

              spacing: 16,
              // Horizontal space between items (this is just an example value of 16 px, you can use any value you want)

              runSpacing: 16,
              // Vertical space between rows (this is just an example value of 16 px, you can use any value you want)

              children: const [
                // The following is the list of logos displayed using the LogoImage widget
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
  final String
      path; // path is the image file path in this case, we use it to load the image from assets
  // An example of path in this code would be 'assets/images/FacensLogo.png'

  const LogoImage(this.path, {super.key});
  // This line defines how to create an object of the LogoImage class
  // this.path assigns the path provided to the 'path' variable
  // For example, in LogoImage('assets/images/FacensLogo.png'), the value of the 'path' variable would be 'assets/images/FacensLogo.png'

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      // Loads the image from assets using the given path

      width: 60,
      // Sets the image width to 60 px (this is just an example value, you can use any value you want)

      height: 60,
      // Sets the image height to 60 px (this is just an example value, you can use any value you want)

      fit: BoxFit.contain,
      // Makes sure the image fits without being cropped or stretched, scaling if necessary
    );
  }
}
