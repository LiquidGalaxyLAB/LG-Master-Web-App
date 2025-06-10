// -----------------------------------IMPORT PACKAGES-----------------------------------
// The first thing you have to do in the main.dart archive is import packages
// The structure to import packages in Flutter is as follows

import 'package:flutter/material.dart'; // This line imports the Flutter tools needed to build an app, so it works as a great example
// What it is doing is importing the library material.dart (which contains common widgets like buttons, text, etc.) from
// Flutter's SDK (Software Development Kit)
// Another few examples would be:

// import 'package:provider/provider.dart';
// This imports the provider library (an external package) and the archive provider.dart

// import 'package:my_project/providers/splash_screen.dart';
// my_project would be the local package of our project, which should be defined in pubspec.yaml (for more info check this archive)
// This line imports an internal archive from our project called splash_screen.dart from the folder lib/providers/

// -----------------------------------MAIN FUNCTION-----------------------------------
// The main function is the first thing that runs when the app starts
void main (){
    runApp(MyApp()); // This line makes Flutter show the MyApp widget on the screen
                     // Basically it shows your app (in this case it is called MyApp()) on the screen
}

// -----------------------------------MYAPP CLASS-----------------------------------
// MyApp class is not the root widget, but the starting point of the user interface
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter),
// we would use StatefulWidget
class MyApp extends StatelessWidget {
    @override // This line tells your app that your are replacing a method that already exists ON PURPOSE
    Widget build(BuildContext context) {
        // MaterialApp is a widget that seys up the whole app
        // It provides settings like navigation or themes
        return MaterialApp(
            title: 'LG Master Web Application', //The name of the app
            
            // For the look of the app (colours, fonts, etc):
            theme: ThemeData(
                primarySwatch: Colors.blue, //In this case, sets blue as the main color
                                            //But you can choose any colour you want
            ),
            home: MyHomePage(), //Sets HomePage() as the first screen      
        );
    }
}

// -----------------------------------PAGE EXAMPLE-----------------------------------
// Let's create an example of a basic page using HomePage, which is used in the MyApp class
// In this case, like with MyApp, it is stateless, which means the content does not update by itself
class HomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context){  // Method used to build the UI of this widget
                                         // The parameter context gives access to theme, size, etc
        
        // Scaffold creates an structure for the screen, kind of like an skeleton
        return Scaffold(
            // Top bar of the app, often used for navigation or titles
            appBar: AppBar(
                title: Text('Welcome to my project'), // Text in the top bar
                                                      // In this case, it saysa 'Welcome to my project'
            ),
            
            // Main content area of the screen
            body: Center(  // 'Center' places everything in the middle of the screen
                child: Text(
                    'Hello world', // Example of a displayed text
                    style: TextStyle(fontSize:12), // Sets the size of the text
                                                   // CAREFUL: its fontSize, not fontsize!!
                ),
            ),
        ),
    }
}
