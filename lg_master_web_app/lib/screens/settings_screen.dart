// -------------------------------------------- SETTINGS SCREEN --------------------------------------------
// Screen dedicated to manage the reboot of the LG, to save the credentials, to clean the KML, to disconnect the LG

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import '../../services/lg_service.dart'; // Imports the service screen, which handles the logic to connect to the Liquid Galaxy screen

// ---------------------- Settings screen widget ----------------------
// SettingsScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<SettingsScreen> createState() => _SettingsScreenState();
  // This line creates the mutable state associated with SettingsScreen
  // The state object will hold the logic for what the settings screen does
}

// ---------------------- Settings screen state ----------------------
// This class manages the state (in other words, the behavior) of the settings screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _SettingsScreenState extends State<SettingsScreen> {
  final LgService lgService = LgService();

  bool isConnected = false;
  // Variable that tracks if the app is currently connected to the Liquid Galaxy
  // Returns true if it is connected
  // Returns false if it is not connected (this is the case by default)

  bool isConnecting = false;
  // Variable that tracks if the app is in the process of connecting to the Liquid Galaxy
  // Returns true if it is connected
  // Returns false if it is not connected (this is the case by default)

  int retryCount = 0;
  // Counter to track how many times a connection retry has happened

  final int maxRetries = 5;
  // Maximum number of retry attempts allowed per user when trying to connect
  // You can choose the number you want
  // This is necessary because, if the app kept crashiing forever, it would waste resources, freeze the app, etc.

  // -------- User and password --------
  final TextEditingController userController =
      TextEditingController(text: 'lg');
  // Declares a final variable named userController
  // final means this variable can only be assigned ONCE and will not change
  // This variable manages the text input for the username field, being initialized with the default text 'lg'
  // It allows to read or modify the text typed by the user in that input field

  final TextEditingController passwordController =
      TextEditingController(text: 'lg');
  // Declares a final variable named passwordController
  // final means this variable can only be assigned ONCE and will not change
  // This variable manages the text input for the password field, being initialized with the default text 'lg'
  // It allows to read or modify the text typed by the user in that input field

  // -------- Connection retry function --------
  Future<void> tryConnect() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      isConnecting = true;
      // Indicates that a connection attempt is in progress

      retryCount = 0;
      // Resets the retry counter to zero before starting the connection attempts
    });

    // -------- Update credentials before connecting --------
    lgService.updateCredentials(
      // Updates these values inside the lg_service.dart file so they are used for the connection
      // This method runs automatically before connecting
      // It makes sure the credentials being used are the most recent ones
      // Tries to immediately connect afterwards

      newUser: userController.text,
      // Gets the username typed by the user and stores it in the 'newUser' variable

      newPassword: passwordController.text,
      // Gets the password typed by the user and stores it in the 'newPassword' variable
    );

    bool success = false;
    // 'success' is a variable used to keep track of whether the connection attempt is successful
    // The default value is false because this means we have not connected yet and are going to try now
    // This allows the loop to begin and keeps track of whether a connection was finally established

    while (retryCount < maxRetries && !success) {
      // Loop that starts to connect repeatedly ONLY IF:
      // The number of attempts (retryCount) is less than the maximum allowed (maxRetries)
      // The connection has not succeeded yet (!success)

      success = await lgService.connectToLG();
      // 'await' pauses execution until the connection attempt finishes
      // If the condition is true, success = true and the loop exists

      if (!success) {
        // If the connection fails

        retryCount++;
        // The retry counter increases by one (if it was 0, now it is 1, etc.)
        // The retrys are for EACH user
        // This means that, with the same user, they can try up to 5 times
        // To reset this counter, change the user (the credentials) and try connecting again

        await Future.delayed(const Duration(seconds: 2));
        // Adds a short delay (2 seconds) between connection attempts
        // This helps to avoid spamming the server or overwhelming the network
        // You can change any value you want, just make sure is not too small or too big
      }
    }

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      isConnected = success;
      // Will be true if the connection succeeded, will be false otherwise

      isConnecting = false;
      // If it is false it will stop showing the loading indicator
      // This lets the user know there is no connecting attempt going on
      // The connection has either succeeded or failed
    });

    final snackBar = SnackBar(
      // A SnackBar widget is a temporary notification message that appears at the bottom of the screen
      // Used to inform the user about an action or state change (success, failure, warning, etc.) without interrupting what the user is doing

      content: Text(success
          ? 'Connected to the Liquid Galaxy'
          : 'Failed to connect to the Liquid Galaxy'),
      // Message that will be shown to the user
      // The message changes depending on the value of the 'success' variable
      // If success is true, it shows 'Connected to the Liquid Galaxy'
      // If success is false, it shows 'Failed to connect to the Liquid Galaxy'
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Shows the SnackBar widget on the screen
  }

  // -------- Disconnect method --------
  void disconnect() {
    lgService.disconnect();
    // Calls the disconnect() method from the lg_service.dart file
    // This terminates the SSH session, disconnecting the Liquid Galaxy

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      isConnected = false;
      // Updates the isConnected value to false, meaning that we are no longer connected to the Liquid Galaxy
    });

    ScaffoldMessenger.of(context).showSnackBar(
      // Shows the SnackBar widget on the screen

      const SnackBar(content: Text('Disconnected from the Liquid Galaxy')),
      // Message that will be displayed on the SnackBar on the screen
    );
  }

  // -------- Save credentials --------
  void saveCredentials() {
    lgService.updateCredentials(
      // Calls the updateCredentials() method from the lg_service.dart file
      // This method runs when the user taps the 'Save Credentials' button
      // It explicitly lets the user save their credentials
      // Does NOT try to connect, only stores data

      newUser: userController.text,
      // Gets the username typed by the user and stores it in the 'newUser' variable

      newPassword: passwordController.text,
      // Gets the password typed by the user and stores it in the 'newPassword' variable
    );

    ScaffoldMessenger.of(context).showSnackBar(
      // Shows the SnackBar widget on the screen

      const SnackBar(content: Text('The credentials were updated')),
      // Message that will be displayed on the SnackBar on the screen
    );
  }

  // -------- Clear KML --------
  Future<void> clearKML() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    if (!isConnected) {
      // Checks if the app is NOT connected to the Liquid Galaxy
      // In case the app is NOT connected:

      ScaffoldMessenger.of(context).showSnackBar(
        // Shows the SnackBar widget on the screen

        const SnackBar(content: Text('Not connected to the Liquid Galaxy')),
        // Message that will be displayed on the SnackBar on the screen
      );

      return;
      // Exits the function early if not connected
      // This prevents trying to clear KML files without a valid connection
    }
    bool result = await lgService.cleanKMLsAndVisualization();
    // Calls the cleanKMLsAndVisualization() method from the lg_service.dart file
    // This function is used to clean the KML layers
    // It stores the result (true or false) in the 'result' variable

    ScaffoldMessenger.of(context).showSnackBar(
      // Shows the SnackBar widget on the screen

      SnackBar(content: Text(result ? 'KML cleared' : 'Failed to clear KML')),
      // Message that will be displayed on the SnackBar on the screen
      // The message changes depending on the value of the 'result' variable
      // If result is true, it shows 'KML cleared'
      // If result is false, it shows 'Failed to clear KML'
    );
  }

  // -------- Reboot LG (calls rebootAllScreens in service) --------
  Future<void> rebootLG() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    if (!isConnected) {
      // Checks if the app is NOT connected to the Liquid Galaxy
      // In case the app is NOT connected:

      ScaffoldMessenger.of(context).showSnackBar(
        // Shows the SnackBar widget on the screen

        const SnackBar(content: Text('Not connected to the Liquid Galaxy')),
        // Message that will be displayed on the SnackBar on the screen
      );

      return;
      // Exits the function early if not connected
      // This prevents trying to clear KML files without a valid connection
    }
    bool result = await lgService.rebootAllScreens();
    // Calls the rebootAllScreens() method from the lg_service.dart file
    // This function is used to reboot the (in this case) 5 screens that are part of the Liquid Galaxy
    // It stores the result (true or false) in the 'result' variable

    ScaffoldMessenger.of(context).showSnackBar(
      // Shows the SnackBar widget on the screen

      SnackBar(
          content: Text(result ? 'Reboot command sent' : 'Failed to reboot')),
      // Message that will be displayed on the SnackBar on the screen
      // The message changes depending on the value of the 'result' variable
      // If result is true, it shows 'Reboot command sent'
      // If result is false, it shows 'Failed to reboot'
    );
  }

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc

  @override
  // Override the 'build' method from the State class

  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('Settings'),
        // Title displayed in the app bar

        backgroundColor: Colors.cyan,
        // Sets the background color of the screen to cyan
        // You can choose any color you want
      ),

      body: Padding(
        // 'body' refers to the main content area of the screen

        padding: const EdgeInsets.all(16),
        // Adds padding of 16 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: ListView(
          // Widget that displays its children linearly
          // It is vertically by default but can also be horizontally
          // In this case, it is used to display the different options in the settings screen

          children: [
            // List of child widgets that will be stacked vertically

            // ------- SETTINGS SCREEN VISUALS -------
            Icon(Icons.settings,
                // Icons.settings is a built-in Flutter icon (an icon that already exists in Flutter) that looks like an engine
                // You can choose other icons

                color: Colors.cyan,
                // Sets the icon color to cyan
                // You can choose other colors

                size: 70
                // Sets the icon size to 70 px
                // You can choose the size you want
                ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 19 px, you can use any value you want
            // This is just an aesthetic choice

            const Text(
              'Liquid Galaxy settings',
              // Text that appears on the screen alongside the icon

              style: TextStyle(
                  // Applies custom styling to the text

                  fontSize: 20,
                  // Sets the text size to 20 px
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

            const SizedBox(height: 24),
            // Adds vertical space between the icon and the text
            // This is just an example value of 24 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- USER AND PASSWORD -------
            // ---- User input field ----
            TextField(
              controller: userController,
              // Connects to the TextEditingController so this value can be read in code

              decoration: const InputDecoration(labelText: 'Username'),
              // Shows 'Username' above the field when is empty or focused
            ),

            // ---- Password input field ----
            TextField(
              controller: passwordController,
              // Connects to the TextEditingController so this value can be read in code

              decoration: const InputDecoration(labelText: 'Password'),
              // Shows 'Password' above the field when is empty or focused

              obscureText: true,
              // Hides the typed characters
              // For example, shows •••••
              // Typical and useful for passwords
            ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 16 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- CREDENTIALS -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              icon: const Icon(Icons.save),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a save disc

              label: const Text('Save credentials'),
              // Text shown on the button

              style: ElevatedButton.styleFrom(
                // Customizes the appeareance of the button

                backgroundColor: Colors.cyan,
                // Sets button background color to cyan
                // You can choose a different color if you want

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want
              ),
              onPressed: saveCredentials,
              // Assigns the function that should run when the button is pressed, in this case saveCredentials()
            ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 16 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- CONNECT/DISCONNECT -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              // The icon and text displayed depend on the connection state
              icon: isConnected
                  ? const Icon(Icons.link_off)
                  // isConnected == true shows a link_off icon (similar to a broken chain)
                  // This is because, if the connection is established, the option you have now is to end it

                  : isConnecting
                      ? const CircularProgressIndicator(color: Colors.white)
                      // isConnecting == true shows a white cirular progres indicator

                      : const Icon(Icons.link),
              // isConnecting == false shows a link icon
              // This is because, if the connection is not established and is also not being established
              // The only option you have is to try and establish a connection

              label: Text(isConnected
                  ? 'Disconnect'
                  // If isConnected == true shows the 'Disconnect' text on the button
                  // This is because, if the connection is established, the option you have now is to end it

                  : isConnecting
                      ? 'Connecting...'
                      // isConnecting == true shows the 'Connecting...' text on the button

                      : 'Connect to the Liquid Galaxy'),
              // isConnecting == true shows the 'Connect to the Liquid Galaxy' text on the button
              // This is because, if the connection is not established and is also not being established
              // The only option you have is to try and establish a connection

              style: ElevatedButton.styleFrom(
                // Sets the button appearance

                backgroundColor:
                    // The background color depends on the connection state

                    isConnected ? Colors.redAccent : Colors.cyan,
                // isConnected == true shows a red background (this goes along with the disconnect option)
                // isConnected == false shows a red background (this goes along with the connect option)

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want
              ),
              onPressed: isConnected ? disconnect : tryConnect,
              // Assigns the function that should run when the button is pressed
              // In this case it depends on the isConnected value
              // isConnected == true calls the disconnect method
              // isConnected == false calls the connect method
            ),

            const SizedBox(height: 24),
            // Adds vertical space between the icon and the text
            // This is just an example value of 24 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- CLEAR KML -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              icon: const Icon(Icons.cleaning_services),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like cleaning icon

              label: const Text('Clear KML'),
              // Text shown on the button

              style: ElevatedButton.styleFrom(
                // Customizes the appeareance of the button

                backgroundColor: Colors.orange,
                // Sets button background color to orange
                // You can choose a different color if you want

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want
              ),
              onPressed: clearKML,
              // Assigns the function that should run when the button is pressed, in this case clearKML()
            ),

            const SizedBox(height: 16),
            // Adds vertical space between the icon and the text
            // This is just an example value of 16 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- REBOOT -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              icon: const Icon(Icons.restart_alt),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a restart circle

              label: const Text('Reboot Liquid Galaxy'),
              // Text shown on the button

              style: ElevatedButton.styleFrom(
                // Customizes the appeareance of the button

                backgroundColor: Colors.deepPurple,
                // Sets button background color to deep purple
                // You can choose a different color if you want

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want
              ),
              onPressed: rebootLG,
              // Assigns the function that should run when the button is pressed, in this case rebootLG()
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            // ------- GOING BACK -------
            ElevatedButton.icon(
              // Creates a button with both icon and text

              icon: const Icon(Icons.arrow_back),
              // 'icon' specifies the icon that will be displayed on the button
              // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a arrow pointing to the left

              label: const Text('Back'),
              // Text shown on the button

              style: ElevatedButton.styleFrom(
                // Customizes the appeareance of the button

                backgroundColor: Colors.cyan,
                // Sets button background color to cyan
                // You can choose a different color if you want

                foregroundColor: Colors.white,
                // Sets icon and text color to white in this case
                // You can choose a different color if you want
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
