// This file is for the HELP SCREEN of your app
// This will have information like FAQs or an explanation on how the app works

import 'package:flutter/material.dart'; // This line imports the Flutter tools needed to build an app, so it works as a great example
                                        // What it is doing is importing the library material.dart (which contains common widgets like buttons, text, etc.) from
                                        // Flutter's SDK (Software Development Kit)

// HelpScreen class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key}); // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it

  @override
  Widget build(BuildContext context) {  // Method used to build the UI of this widget
                                        // The parameter context gives access to theme, size, etc
    // Scaffold creates an structure for the screen, kind of like an skeleton
    return Scaffold(
      // Top bar of the app, often used for navigation or titles
      appBar: AppBar(
        title: const Text('Help'), // Title displayed in the app bar
      ),
      // Main content area of the screen
      body: const Center( // 'Center' places everything in the middle of the screen
        child: Text('Welcome to the help screen!'), // Main content
      ),
    );
  }
}
