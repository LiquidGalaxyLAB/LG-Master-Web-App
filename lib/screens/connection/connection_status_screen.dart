// -------------------------------------------- CONNECTION STATUS SCREEN --------------------------------------------
// This screen is displayed after the user attempts a connection to Liquid Galaxy
// It shows whether the connection was successful or not as well as the entered IP and port

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)

// ---------------------- Connection status widget ----------------------
// This class defines the status screen shown after attempting a connection
// ConnectionStatusScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget

class ConnectionStatusScreen extends StatelessWidget {
  // ------------- Parameters passed from the Connection screen -------------

  final String ipAddress; // IP addres introduced by the user
  final int port; // Port number introduced by the user
  final bool isConnected; // To track if the connection was successful or not

  const ConnectionStatusScreen({
    super.key,
    // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
    // This helps Flutter identify and track this widget when rebuilding the screen
    // It basically passes an optional key to the parent widget for identification during widget rebuilds

    required this.ipAddress,
    // 'required' makes that the ipAddress value is always provided

    required this.port,
    // 'required' makes that the port value is always provided

    required this.isConnected,
    // 'required' makes that the value of the connection (true or false) is always provided
  });

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  // ---------------------- Build the screen interface ----------------------
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('Connection Status'),
        // Title displayed in the app bar

        backgroundColor: Theme.of(context).colorScheme.primary,
        // The app bar color is derived from the current app theme
      ),

      body: Container(
        // 'body' refers to the main content area of the screen

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          // 'Center' places everything in the middle of the screen
          // This widget stacks its children vertically and centers them

          child: Padding(
            // Padding is used to add space around the button

            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            // Adds padding of 24 px to all sides (top, bottom, left, right)
            // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
            // If you wanted to add padding on top, bottom, left and right you would use EdgeInsets.all(8.0);
            // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            // You can add padding on individual sides, for example:
            // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
            // EdgeInsets.only(left: 8.0, top: 10.0)

            child: Column(
              // Stacks widgets vertically

              mainAxisAlignment: MainAxisAlignment.center,
              // Puts them in the center vertically

              children: [
                // List of child widgets that will be stacked vertically

                Icon(
                  // Displays the icon specified
                  isConnected
                      ? Icons.check_circle_outline
                      : Icons.error_outline,
                  // This line defines what icon shows depending on if the connection was successful or not
                  // isConnected is the variable we created to check if the connection was succesful or not
                  // A ternary operator works with the following structure:
                  // condition ? valueIfTrue : valueIfFalse
                  // This means that, in this case, if isConnected == true, it shows a check icon (check_circle_outline)
                  // And if isConnected == false, it shows an error icon (error_outline)

                  color: isConnected ? Colors.greenAccent : Colors.redAccent,
                  // This line defines the color of the icon that shows depending on is the connection was successful or not
                  // isConnected is the variable we created to check if the connection was succesful or not
                  // A ternary operator works with the following structure:
                  // condition ? valueIfTrue : valueIfFalse
                  // This means that, in this case, if isConnected == true, it shows a green icon (greenAccent)
                  // And if isConnected == false, it shows an red icon (redAccent)

                  size: 80,
                  // In this case, the size of the icons is 80 px
                  // You can choose the size you want
                ),

                const SizedBox(height: 20),
                // Adds vertical space between the icon and the text
                // This is just an example value of 20 px, you can use any value you want
                // This is just an aesthetic choice

                Text(
                  // Displays the text that accompanies the icon
                  isConnected
                      ? '✅ Connected to Liquid Galaxy!'
                      : '❌ Connection to Liquid Galaxy failed',
                  // This line defines text shows depending on if the connection was successful or not
                  // isConnected is the variable we created to check if the connection was succesful or not
                  // A ternary operator works with the following structure:
                  // condition ? valueIfTrue : valueIfFalse
                  // This means that, in this case, if isConnected == true, it shows '✅ Connected to Liquid Galaxy!'
                  // And if isConnected == false, it shows '❌ Connection to Liquid Galaxy failed'

                  style: const TextStyle(
                    // Applies custom styling to the text

                    fontSize: 22,
                    // Sets the text size to 22 px
                    // As always, this is just an example value

                    fontWeight: FontWeight.bold,
                    // Makes the text bold by applying a heavier font weight
                    // You can also use values like FontWeight.w600 or just w600
                    // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                    // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)

                    color: Colors.white,
                    // Sets the text color to white
                  ),

                  textAlign: TextAlign.center,
                  // Aligns the text horizontally to the center of its container
                ),

                const SizedBox(height: 40),
                // Adds vertical space between the icon and the text
                // This is just an example value of 40 px, you can use any value you want
                // This is just an aesthetic choice

                // ---------------------- Show IP and port info ----------------------
                Text(
                  'IP Address: $ipAddress\nPort: $port',
                  // Displays the IP and the port introduced by the user

                  style: const TextStyle(
                    // Applies custom styling to the text

                    fontSize: 18,
                    // Sets the text size to 18 px
                    // As always, this is just an example value

                    color: Colors.white70,
                    // Sets the text color to white70
                    // You can choose the color you want
                  ),

                  textAlign: TextAlign.center,
                  // Aligns the text horizontally to the center of its container
                ),

                const SizedBox(height: 50),
                // Adds vertical space between the icon and the text
                // This is just an example value of 50 px, you can use any value you want
                // This is just an aesthetic choice

                ElevatedButton.icon(
                  // Creates a button with both icon and text

                  onPressed: () => Navigator.pop(context),
                  // Assigns the function that should run when the button is pressed
                  // Navigator.pop tells Flutter to close the current screen and go back to the previous one (context)

                  icon: const Icon(Icons.arrow_back),
                  // Displays the icon specified
                  // In this case, an arrow pointing to the left (arrow_back)

                  label: const Text('Back'),
                  // Text that accompanies the icon

                  style: ElevatedButton.styleFrom(
                    // Customizes the appeareance of the button

                    backgroundColor: Colors.orange,
                    // Sets button background color to orange in this case (you can choose any color you want)

                    foregroundColor: Colors.white,
                    // Sets icon and text color to white in this case

                    minimumSize: const Size(160, 50),
                    // Button size, in this case it forces it to be at least 160 px wide and 50 px tall

                    shape: RoundedRectangleBorder(
                      // Gives the button rounder corners

                      borderRadius: BorderRadius.circular(30),
                      // In this case, it uses a radius of 30 px
                    ),

                    elevation: 5,
                    // Adds a shadow to make the button look raised
                    // It has to be a double
                    // 0 is no shadow, you can set any positive number but above 24 it usually doe snot have much visual effect
                    // Higher numbers mean a bigger, softer shadow, making the button look more lifted above the surface
                    // Lower numbers mean a smaller, sharper shadow, making the button appear closer to the background
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
