// This file is the SPLASH SCREEN
// A splash screen is typically a welcome screen that appears when we open an app
// In this case it will display the logos of Liquid Galaxy and your project

import 'dart:async';  // Imports the Dart asynchronous tools needed for Timer
import 'package:flutter/material.dart';  // This line imports the Flutter tools needed to build an app, so it works as a great example
                                         // What it is doing is importing the library material.dart (which contains common widgets like buttons, text, etc.) from
                                         // Flutter's SDK (Software Development Kit)
import 'main_screen.dart'; // Import the main screen file (to navigate after the logos disappear)

// SplashScreen class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it

  @override
  State<SplashScreen> createState() => _SplashScreenState();  // This line tells Flutter how to create the state object for thsi widget
                                                              // The state object will hold the logic for what the splash screen does
}

// This is the state class of the splash screen
// It holds the logic for timing and navigation
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to MainScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {  // This sets a timer for 3 seconds
                                            // This is just an example value, you can put the value you want
                                            // However, keep in mind that this is a splash screen, so do not put a value that is too high
                                            // After 3 seconds, it navigates to the main screen and replaces the splash screen, which means users cannot go back to it
      // Changes the current screen
      Navigator.of(context).pushReplacement(  
        MaterialPageRoute(builder: (_) => const MainScreen()),   
      );
    });
  }

  @override
  Widget build(BuildContext context) { // Method used to build the UI of this widget
                                       // The parameter context gives access to theme, size, etc
    // Scaffold creates an structure for the screen, kind of like an skeleton
    return Scaffold(
      backgroundColor: Colors.blue, // Background color of splash screen, in this example is set to blue
      // Main content area of the screen
      // 'Center' places everything in the middle of the screen
      body: Center(
        // This widget stacks its children vertically and centers them
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displays a large, white icon in the center
            // To be change with your own icon
            Icon(
              'assets/images/LGMasterWebAppLogo.png', // Update this with your icon
                                                      // It should be located in the 'images' folder inside the 'assets' folder
                                                      // It should also be added in the pubspec.yaml file the following way, check that file to see how
              size: 100,
            ),
            const SizedBox(height: 20), // Adds vertical space between the icon and the text
            const Text(
              'LG Master Web App', // App name
              style: TextStyle(
                fontSize: 24,  // Sets the size of the text
                               // CAREFUL: its fontSize, not fontsize!!
                fontWeight: FontWeight.bold,  // Bold style
                color: Colors.white,  // Sets the color of the text
              ),
            ),
            const SizedBox(height: 10), // Adds vertical space between the text and the loading indicator
            // Shows a spinning circle to indicate loading
            const CircularProgressIndicator(
              color: Colors.white, // In this example the spinning circle is white
            ),
          ],
        ),
      ),
    );
  }
}
