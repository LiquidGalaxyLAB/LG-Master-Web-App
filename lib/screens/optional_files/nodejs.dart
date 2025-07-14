// -------------------------------------------- NODEJS SCREEN --------------------------------------------
// This screen gives information about how to integrate a Node.js server on your project
// This server is external to the project
// In this case, I uploaded it in Render, a cloud application platform
// The server.js file and the package.json file that were use to create the remote server can be checked
// on the node_server folder of this this project
// However, these files are not used directly, the REMOTE server is used directly
// The files are just on the project so you can check what a server looks like

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:http/http.dart'
    as http; // HTTP client to send requests to the Node.js server

// ---------------------- Node.js screen widget ----------------------
// NodeJsScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class NodeJsScreen extends StatefulWidget {
  const NodeJsScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<NodeJsScreen> createState() => _NodeJsScreenState();
  // This line creates the mutable state associated with NodeJsScreen
  // The state object will hold the logic for what the Node.js screen does
}

// ---------------------- Node.js screen state ----------------------
// This class manages the state (in other words, the behavior) of the Node.js screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _NodeJsScreenState extends State<NodeJsScreen> {
  String _status = 'Press the button to check Node.js server status';
  // _status shows the current status of the server to the user
  // This is just a default prompt string to initialize it

  final String nodeServerUrl = 'https://server-nodejs-0111.onrender.com';
  // Change this with the URL of your own backend server

  // ---- Send prompt to the server ----
  Future<void> _checkNodeStatus() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      _status = 'Checking...';
      // Updates the _status string to inform the user that the status of the server is being checked
    });

    try {
      // ---- Send HTTP GET request to the Node.js server/status endpoint ----
      final response = await http.get(Uri.parse('$nodeServerUrl/status'));
      // Sends an HTTP GET request asynchronously
      // http.get is used to make a GET request
      // 'response' stores the result of the HTTP call

      // ---- Handle Node.js server/status response ----
      if (response.statusCode == 200) {
        // Check if the response was successful (200 is code for 'OK')

        setState(() {
          // setState() is used to rebuild the UI when the state changes

          _status = 'Node.js server response:\n${response.body}';
          // Update the status string with the server response body
          // Displays the ACTUAL response from the ACTUAL server
        });
      } else {
        // If the response was NOT successful (NOT 200)
        setState(() {
          // setState() is used to rebuild the UI when the state changes

          _status = 'Server responded with status code ${response.statusCode}';
          // Update status to show the unexpected status code receive
          // It is shown when the server responds but with a code different from 200
        });
      }
    } catch (e) {
      // If an exception occurred during the HTTP request (for example, a network error)
      // Basically when something goes wrong even before catching a response

      setState(() {
        // setState() is used to rebuild the UI when the state changes

        _status = 'Error connecting to Node.js server:\n$e';
        // Update status to display the error message
      });
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
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
          // Top bar of the app, often used for navigation or titles

          title: const Text('Node.js integration example')
          // Title displayed in the app bar

          ),
      body: Padding(
        // 'body' refers to the main content area of the screen

        padding: const EdgeInsets.all(20.0),
        // Adds padding of 20 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: Column(
          // Stacks widgets vertically

          children: [
            // List of child widgets that will be stacked vertically

            Text(_status,
                style: const TextStyle(
                    // Applies custom styling to the text

                    fontSize: 16)
                // Sets the text size to 16 px
                // As always, this is just an example value
                ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            ElevatedButton(
              onPressed: _checkNodeStatus,
              // This line defines what happens when the user presses the button
              // In this case it calls the custom method we design to contact the server

              child: const Text('Check Node.js server status'),
              // Text displayed on the button
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            const Text(
              'Make sure your Node.js server is running on the given URL with /status endpoint!',
              // Text displayed on the screen, will be seen by the user

              style: TextStyle(
                  // Applies custom styling to the text

                  color: Colors.grey
                  // Color of the text, in this case is set to grey
                  // As always, you can choose any color you want
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
