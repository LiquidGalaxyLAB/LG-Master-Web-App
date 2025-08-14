// -------------------------------------------- QR CODE SCREEN --------------------------------------------
// Screen used to read a QR file and use it to connect to the Liquid Galaxy

// ---------------------- Import packages ----------------------
import 'dart:convert'; // For coding and decoding JSON
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:mobile_scanner/mobile_scanner.dart'; // Used to scan QR codes and barcodes using the phone camera, must also be added on the pubspec.yaml file
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)

import '../../providers/theme_provider.dart'; // Imports the file related to managing the light mode and the dark mode of the app
import '../../providers/settings_provider.dart'; // Imports the file related to managing the text sizes
import '../../services/lg_service.dart'; // Imports the LG service screen, which handles the logic to connect to the Liquid Galaxy screen

// ---------------------- QR screen widget ----------------------
// QRScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class QRScreen extends StatefulWidget {
  const QRScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<QRScreen> createState() => _QRScreenState();
  // This line creates the mutable state associated with QRScreen
  // The state object will hold the logic for what the QR screen does
}

// ---------------------- QR screen state ----------------------
// This class manages the state (in other words, the behavior) of the QR screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _QRScreenState extends State<QRScreen>
    with SingleTickerProviderStateMixin {
  // This line lets this class act as a TicketProvider, which is required to run animations like AnimationController
  // A Ticker is basically like a metronome for animations, as it is used to keep track of time

  final MobileScannerController controller = MobileScannerController();
  // Creates a controller for the QR code scanner
  // This controller lets you start, stop and configure the whole QR scanning process

  late AnimationController _animationController;
  // Variable that controls the timing of an animation

  late Animation<double> _animation;
  // Variable that defines how the animation value changes over time (from 0 to 1)
  // This values are explained later

  bool _hasError = false;
  // Variable that is used to track if an error message is already being shown
  // Useful to prevent multiple popups from stacking if multiple QR codes that give errors are scanned quickly
  // Initialized as false because, when we open the camera, we have not scanned any code yet

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  void initState() {
    // initState() is a method that runs once when the screen first loads or the widget is first created
    // It acts as a setup function, and that is why is only run once
    // Once the setup is done there's no need to set up everything again (unless the widget is removed and added back)

    super.initState();
    // super.initState() calls the default setup behavior from the parent class (in this case, the State class from Flutter)
    // It basically indicates Flutter to set up its own things first, and then we'll add our own things later

    _animationController = AnimationController(
      // Creates the object in charge of the animation over time (AnimationController) and stores it in the "animationController" variable
      // AnimationController is an object that produces values (usually from 0 to 1) that change over time
      // From 0 (start of the animation path) to 1 (end of the animation path) because these values are normalized

      vsync: this,
      // vsync means vertical synchronization, and it is a parameter that links the animation to the screen refresh rate
      // "this" refers to the QRScreenState class, which links vsync to the value of the ticker

      duration: const Duration(seconds: 2),
      // duration states how long one full animation cycle stats
      // In this case, it will take 2 seconds to go from the start point (0) to the end (1)
      // This value can be changed to be faster or slower
    )..repeat(reverse: true);
    // ".." is a cascade operator in Dart, which allows to call a method on the object right after creating it
    // In this case, it calls the repeat() method
    // This method allows to repeat the animation indefinetely, reversing the animation once it reaches the end
    // This means that, once it goes from 0 to 1, it will go from 1 to 0, etc.

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    // Tween defines the range of values the animation should produce
    // begin: 0, end: 1 means that the start value will be 0 and the end value will be 1
    // .animate(_animationController) connects this range to the controller
    // Stores the result in the _animation variable
  }

  // -------- showError() method --------
  // Used to show the user an error notification in case the scanning fails

  void _showError(String message) {
    // Defines a method that does not return any value (void)
    // It takes one parameter, message, which is the text that will be shown in the notification

    if (!_hasError && mounted) {
      // "hasError" is a variable we defined earlier in the code
      // "mounted" is a property of the State class that is "true" if the widget is currently displayed on the screen
      // In this case, if noth hasError AND mounted are true, it means there has been an error

      setState(() => _hasError = true);
      // setState() is used to rebuild the UI when the state changes
      // In this case, if we are inside this condition it menas hasError is true
      // But it was initialized to false, so we have to make sure it has the correct and current value (true)

      ScaffoldMessenger.of(context).showSnackBar(
        // Scaffold is a basic page layout that creates an structure for the screen
        // Shows a temporary message (a SnackBar) at the bottom of the screen

        SnackBar(
          content:
              // This is the content that will be shown in the message

              Text(message,
                  // "message" is the message we introduced when calling the showError() method

                  style: const TextStyle(
                      // Applies custom styling to the text

                      color: Colors.white
                      // In this case, the color of the text will be white
                      // You can choose any color you want
                      )),
          backgroundColor: Colors.black87,
          // Background color of the message
          // I chose a dark color so it could contrast with the white text but you can choose any color you want

          duration: const Duration(seconds: 3),
          // States the duration of this temporary message on the screen
          // In this case, it is 3 seconds
          // You can choose any value you want, but it is better if it is not too big (remember this is a temporary message)

          onVisible: () {
            // onVisible is a callback that runs when the SnackBar is first shown

            Future.delayed(const Duration(seconds: 2), () {
              // Waits for 2 seconds before running the inner code

              if (mounted) {
                // Checks if mounted = true again to avoid any errors in case the widget is gone

                setState(() => _hasError = false);
                // setState() is used to rebuild the UI when the state changes
                // In this case it sets hasError as false again so, if another error occurs, it can be shown on the screen
              }
            });
          },
        ),
      );
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Access the current instance of ThemeProvider (a class from theme_provider.dart)
    // This class has information on dark and light mode
    // Stores this instance in a variable called "themeProvider"
    // final means this variable can only be assigned ONCE and will not change

    final isDark = themeProvider.isDarkMode;
    // Checks if the app is currently using the dark theme

    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      backgroundColor: isDark ? Colors.black : Colors.white,
      // Changes the backgroundColor depending on the app theme
      // For this, it uses a ternary operator, which works with the following structure:
      // condition ? valueIfTrue : valueIfFalse
      // If we are or dark mode, it will set the background color to black
      // If we are or light mode, it will set the background color to white

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('Scan the QR code'),
        // Title displayed in the app bar

        backgroundColor: isDark ? Colors.grey[900] : Colors.orange,
        // Changes the backgroundColor of the app bar depending on the app theme
        // For this, it uses a ternary operator, which works with the following structure:
        // condition ? valueIfTrue : valueIfFalse
        // If we are or dark mode, it will set the background color to a grey
        // If we are or light mode, it will set the background color to orange
        // These are just the colors I chose, you can choose other colors

        leading: IconButton(
          // "leading" adds an icon at the start (left) of the row
          // IconButton creates a button with an icon

          icon: const Icon(Icons.arrow_back),
          // 'icon' specifies the icon that will be displayed on the button
          // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a arrow pointing to the left

          onPressed: () => Navigator.pop(context),
          // Assigns the function that should run when the button is pressed
          // In this case, Navigator.pop(context) closes the current screen and go back to the previous one
        ),
      ),
      body: Stack(
        // 'body' refers to the main content area of the screen
        // "Stack" is a layout widget that allows multiple children to overlap

        children: [
          // List of child widgets that will be stacked

          MobileScanner(
            // MobileScanner is the QR code scanner widget from the mobile_scanner package

            controller: controller,
            // This line passes the MobileScannerController so you are able to start or stop the scanning

            onDetect: (capture) async {
              // onDetect is a callback function triggered whenever a QR code is detected
              // capture is an object of the type "BarcodeCapture" from the mobile_scanner package
              // This object contains information about all the barcodes detected in the current camera frame
              // 'async' allows to use 'await' inside the function

              if (_hasError) return;
              // This line checks if an error message is currently showing
              // If hasError = true, it exits the function (return)
              // This way, it ignores further scans to avoid multiple error pop-ups

              final barcodes = capture.barcodes;
              // capture.barcodes contains all detected barcodes in the current camera frame
              // In this code, they are stored in a variable called "barcodes"

              if (barcodes.isEmpty) return;
              // If there are no barcodes detected, we exit the function (return)

              final barcode = barcodes.first;
              // If there are multiple barcodes detected, it only takes the first and stores it in a variable called "barcode"

              if (barcode.rawValue == null) return;
              // If this first barcode does not contain a valid string value (rawValue), we exit the function (return)
              // rawValue is a property property of the Barcode object that contains the actual data encoded in the barcode or QR code as a string
              // If rawValue was null, it would mean the scanner detected the barcode or QR shape but could not extract any readable data

              try {
                // try block used to catch any exceptions that may occur

                final Map<String, dynamic> data = jsonDecode(barcode.rawValue!);
                // jsonDecode(barcode.rawValue!) parses the value of this first barcode as a JSON object
                // ! indicates that barcode.rawValue is NOT null
                // This parsed value is stored in the "data" variable
                // Map<String, dynamic> is a Dart type that describes the kind of data the "data" variable will hold
                // In this case, it will be a dictionary with string keys and values of any type (perfect for JSON data)

                final connectionModel = LgConnectionModel(
                  // Creates a new instance of the LgConnectionModel class (which comes from lg_service.dart)
                  // Stores this instance in a variable called 'connectionModel'
                  // final means this variable can only be assigned ONCE and will not change

                  username: data['username'] ?? '',
                  // Gives to "username" the value associated with the key "username" from the "data" map
                  // If this value is null, the fallback value (the value after ??) is used ('' in this case)

                  ip: data['ip'] ?? '',
                  // Gives to "ip" the value associated with the key "ip" from the "data" map
                  // If this value is null, the fallback value (the value after ??) is used ('' in this case)

                  port: int.tryParse(data['port'].toString()) ?? 22,
                  // Gives to "port" the value associated with the key "port" from the "data" map
                  // int.tryParse() converts a String to an int (a process called parsing)
                  // If parsing fails, the fallback value (the value after ??) is used (22 in this case)

                  password: data['password'] ?? '',
                  // Gives to "password" the value associated with the key "password" from the "data" map
                  // If this value is null, the fallback value (the value after ??) is used ('' in this case)

                  screens: int.tryParse(data['screens'].toString()) ?? 5,
                  // Gives to "screens" the value associated with the key "screens" from the "data" map
                  // int.tryParse() converts a String to an int (a process called parsing)
                  // If parsing fails, the fallback value (the value after ??) is used (5 in this case)
                );

                if (connectionModel.username.isNotEmpty &&
                    connectionModel.ip.isNotEmpty &&
                    connectionModel.password.isNotEmpty) {
                  // Checks that NONE of the required fields (username, ip, password) are empty

                  await controller.stop();
                  // "controller" is the MobileScannerController instance that controls the camera and scanning behavior
                  // .stop() is a method that stops the scanner and the camera
                  // The camera preview will freeze and the onDetect callback will no longer be called
                  // await pauses the execution until the process in this line is completed

                  if (mounted) {
                    // Checks if mounted = true to avoid any errors in case the widget is gone

                    Navigator.pop(context, connectionModel);
                    // Navigator.pop(context) closes the current screen and go back to the previous one
                    // connectionModel in this line means that it also returns the data in the connectionModel variable to the previous screen
                    // In this case, the previous screen is dedicated to the connection to the Liquid Galaxy
                  }
                } else {
                  // In case ANY of the required fields are empty:

                  _showError('Invalid QR: Fields cannot be empty');
                  // It calls the showError() method so it can communicate this to the user
                }
              } catch (e) {
                // If jsonDecode or anything else in the try block fails:

                _showError('Invalid QR: Incorrect format');
                // It calls the showError() method so it can communicate this to the user
              }
            },
          ),
          Center(
            // Centers all the widgets vertically and horizontally

            child: Container(
              width: 280,
              // Width of the container (this is just an example value of 280 px, you can use any value you want)

              height: 280,
              // Height of the container (this is just an example value of 280 px, you can use any value you want)

              child: AnimatedBuilder(
                // AnitamedBuilder is used to rebuild the child everytime the value of "_animation" changes

                animation: _animation,
                // "_animation" is the value from 0 to 1 we defined earlier

                builder: (context, child) {
                  // Defines how the AnimatedBuilder widget should rebuild itself as the animation progresses
                  // "context" menas it uses the current animation value to do so

                  return Align(
                    // Align moves the child in the Y axis coordinates

                    alignment: Alignment(0, _animation.value * 2 - 1),
                    // Converts a 0 to 1 animation into a -1 to 1 animation
                    // Basically this is what moves the line of the scanner up and down

                    child: Container(
                      // In this case the child is a horizontal thin line with a gradient effect

                      height: 5,
                      // Height of the container (in this case the scanning line, 5 px)

                      width: 260,
                      // Width of the container (in this case the scanning line, 260 px)

                      decoration: BoxDecoration(
                        // 'decoration' is a property of the Container widget that allows to visually style the container
                        // For example, setting borders, gradients, background images, etc

                        gradient: LinearGradient(
                          // Adds a background gradient (a smooth transition between two or more colors)
                          // LinearGradient creates a linear gradient, which means the color change follows a straight line
                          // You can also use RadialGradient or SweepGradient for other gradient effects
                          // You can also just set the background to just one color, this is just an style choice
                          // In this case, the gradient fades in and out to give the scanning line a glowing effect

                          colors: [
                            // Chooses which gradient colors to use

                            Colors.blue.withAlpha(0),
                            Colors.blue.withAlpha(179),
                            Colors.blue,
                            Colors.blue.withAlpha(179),
                            Colors.blue.withAlpha(0),
                            // In this example, the gradient starts with blue.withAlpha(0) and transitions to blue.withAlpha(0)
                            // This colors list can have as many colors as you like
                            // Flutter will automatically distribute them evenly unless you specify where each color transition happens
                            // You can do this with stops, for example:
                            // colors: [Colors.red, Colors.yellow, Colors.green],
                            // stops: [0.0, 0.5, 1.0],
                            // 0.0 is the start, 0.5 is the middle, 1.0 is the end
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
