// -----------------------------------IMPORT PACKAGES-----------------------------------
// The first thing you have to do in the main.dart archive is import packages
// The structure to import packages in Flutter is as follows

import 'package:flutter/material.dart'; // This line imports the Flutter tools needed to build an app, so it works as a great example
// What it is doing is importing the library material.dart (which contains common widgets like buttons, text, etc.) from
// Flutter's SDK (Software Development Kit)
// Another few examples would be:

import 'package:provider/provider.dart';
// This imports the provider library (an external package) and the file provider.dart

import 'config/lg_config.dart';
// This line imports an internal archive from our project called lg_config.dart from the folder lib/config/
// In this project, lg_config.dart is the file in charge of the Liquid Galaxy configuration

import 'services/lg_connection.dart';
// This line imports an internal archive from our project called lg_connnection.dart from the folder lib/services/
// In this project, lg_config.dart is the file in charge of the connection to the Liquid Galaxy

// -----------------------------------MAIN FUNCTION-----------------------------------
// The main function is the first thing that runs when the app starts
void main () => runApp(
    // '=>' is Dart's arrow syntax for functions with a single expression
    // It is a shortcut for void main() {runApp(...);}
    
    MultiProvider( // This line allows the use of multiple providers 
                   // Provider are a special type of widget that makes data available to any widget below it in the widget tree
                   // This avoids having to pass that data down manually through constructors or callbacks
        providers: [
            ChangeNotifierProvider(
                create: (_) => LGConnectionService()   // Provides connection service to the Liquid Galaxy
                                                       // Any widget can access this service and listen for changes like connection status updates
                                                       // _ is a placeholder for the BuildContext parameter, which is not used in this case
                ),
        ],
        child: const MyApp()   // This line makes Flutter show the MyApp widget on the screen
                               // Basically it shows your app (in this case it is called MyApp()) on the screen        
    ),
);

// -----------------------------------MYAPP CLASS-----------------------------------
// MyApp class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter),
// we would use StatefulWidget
class MyApp extends StatelessWidget {
    const MyApp({super.key}); // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
    
    @override // This line tells your app that your are replacing a method that already exists ON PURPOSE
    Widget build(BuildContext context) {
        // MaterialApp is a widget that seys up the whole app
        // It provides settings like navigation or themes
        return MaterialApp(
            title: 'LG Master Web Application', // The name of the app
            
            // For the look of the app (colours, fonts, etc)
            theme: ThemeData(
                primarySwatch: Colors.blue, // In this case, sets blue as the main color
                                            // But you can choose any colour you want
                visualDensity: VisualDensity.adaptivePlatformDensity  // Visual density controls how compact or spacious UI elements appear
                                                                      // This line makes that Flutter uses a compact layout (less space between UI elements) on desktop
                                                                      // and the standard layout (default, more spacious) on mobile 
            ),
            home: const HomePage(),                // Sets HomePage() as the first screen 
            // debugShowCheckedModeBanner: false,  // This makes that Flutter does NOT show the red "DEBUG" banner that appears when running in debug mode
                                                   // By default this banner is visible during development to remind that the app is running in debug mode
                                                   // This line is optional, as it has no effect in release mode because the banner never appears in release builds
        );
    }
}

// -----------------------------------PAGE EXAMPLE-----------------------------------
// Let's create an example of a basic page using HomePage, which is used in the MyApp class in this example
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
                                                      // In this case, it says 'Welcome to my project'
            ),
            
            // Main content area of the screen
            body: Center(  // 'Center' places everything in the middle of the screen
                child: const Text(   // In this line 'const' is optional, but it helps make the code more efficient
                                     // 'const' means that the widget never changes and specifies that there is no need to rebuild                                  
                    'Hello world', // Example of a displayed text
                    style: TextStyle(fontSize:12), // Sets the size of the text
                                                   // CAREFUL: its fontSize, not fontsize!!
                ),
            ),
        );
    }
}
