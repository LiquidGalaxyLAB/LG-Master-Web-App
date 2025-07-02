// -----------------------------------IMPORT PACKAGES-----------------------------------
// The first thing you have to do in the main.dart archive is import packages
// The structure to import packages in Flutter is as follows
import 'package:flutter/material.dart'; // This line imports the Flutter tools needed to build an app, so it works as a great example
// What it is doing is importing the library material.dart
// This library contains common widgets like buttons, text, etc. from Flutter's SDK (Software Development Kit)

// ----------- Import the screens we are going to be using -----------
import 'screens/splash_screen.dart'; // Splash screen with the logos

// -----------------------------------MAIN FUNCTION-----------------------------------
// The main function is the first thing that runs when the app starts
void main() {
  runApp(const MyApp());
}

// A shortcut for this could be void main () => runApp();
// '=>' is Dart's arrow syntax for functions with a single expression

// -----------------------------------MYAPP CLASS-----------------------------------
// MyApp class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter),
// we would use StatefulWidget
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  }); // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it

  // This widget is the root of your application
  @override // This line tells your app that your are replacing a method that already exists ON PURPOSE
  Widget build(BuildContext context) {
    // MaterialApp is a widget that seys up the whole app
    // It provides settings like navigation or themes
    return MaterialApp(
      title: 'LG Master Web Application', // The name of the app
      // For the look of the app (colours, fonts, etc)
      theme: ThemeData(
          // primarySwatch: Colors.blue, // In this case, sets blue as the main color
          // But you can choose any colour you want
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          visualDensity: VisualDensity
              .adaptivePlatformDensity // Visual density controls how compact or spacious UI elements appear
          // This line makes that Flutter uses a compact layout (less space between UI elements) on desktop
          // and the standard layout (default, more spacious) on mobile
          ),
      // The first widget the user will see is the splash screen
      home: const SplashScreen(), // Sets SplashScreen() as the first screen

      //debugShowCheckedModeBanner: false, // This makes that Flutter does NOT show the red "DEBUG" banner that appears when running in debug mode
      // By default this banner is visible during development to remind that the app is running in debug mode
      // This line is optional, as it has no effect in release mode because the banner never appears in release builds
    );
  }
}
