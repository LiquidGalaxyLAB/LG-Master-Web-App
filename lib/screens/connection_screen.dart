// -------------------------------------------- CONNECTION SCREEN --------------------------------------------
// This is the screen where the user will introduce the IP and the port related to the Liquid Galaxy
// As well as other LG connection options like clearing KMLs, saving credentials or disconnecting the LG

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)
import '../../services/lg_service.dart'; // Imports the service screen, which handles the logic to connect to the Liquid Galaxy screen
import '../../providers/settings_provider.dart'; // Imports the file we created to manage font sizes

// ---------------------- Connection screen widget ----------------------
// ConnectionScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the createState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<ConnectionScreen> createState() => _ConnectionScreenState();
  // This line creates the mutable state associated with ConnectionScreen
  // The state object will hold the logic for what the connection screen does
}

// ---------------------- Connection screen state ----------------------
// This class manages the state (in other words, the behavior) of the connection screen
// In this case, it triggers the connection attempt
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _ConnectionScreenState extends State<ConnectionScreen> {
  // ------------ LG related variables ------------

  final _formKey = GlobalKey<FormState>();
  // GlobalKey<FormState>() creates a key (an unique identifier) to be used by the 'Form' widget (used later in this file)
  // With '_formKey' we can call '_formKey.currentState!.validate()' to check if all the field in the form are valid
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _usernameController = TextEditingController(text: 'lg');
  // _usernameController is a variable used to manage the input for the username used to access the LG
  // TextEditingController makes it possible to read or modify the content of a TextField widget
  // This one is initialized by default with 'lg'
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _ipController = TextEditingController();
  // _ipController is a variable used to manage the input for the IP
  // TextEditingController makes it possible to read or modify the content of a TextField widget
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _portController = TextEditingController(text: '22');
  // _portController is a variable used to manage the input for the port
  // TextEditingController makes it possible to read or modify the content of a TextField widget
  // This one is initialized by default with '22'
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _passwordController = TextEditingController(text: 'lqgalaxy');
  // _passwordController is a variable used to manage the input for the password used to access the LG
  // TextEditingController makes it possible to read or modify the content of a TextField widget
  // This one is initialized by default with 'lqgalaxy'
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _screensController = TextEditingController(text: '5');
  // _screensController is a variable used to manage the number of screens from the Liquid Galaxy
  // TextEditingController makes it possible to read or modify the content of a TextField widget
  // This one is initialized by default with '5'
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  bool _isConnecting = false;
  // _isConnecting is a variable used to track if the app is in PROCESS of connecting to the LG
  // It is initialized the false because, when the app first starts, it is not in the process of connecting

  bool _isConnected = false;
  // _isConnected is a variable used to track if the app has CONNECTED to the LG
  // It is initialized the false because, when the app first starts, it is not connected

  // ------------ Initialize ------------
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

    _loadSavedSettings();
    // This is a custom method we define later in the code
    // It loads previously saved IP address, username, port, etc.
    // It makes sure that, when the screen first loads, the form fields are already filled in with these previously saved values
  }

  // ---------------------- METHODS ----------------------
  // These methods are defined here and not on lg_service.dart because

  // ------------ loadSavedSettings() ------------
  // Used for showing on the screen the default values of the LG variables that were defined earlier
  // Called when initializing the screen

  Future<void> _loadSavedSettings() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (like updating text fields), not to return data

    final savedModel = await LgConnectionModel.loadFromPreferences();
    // Calls the method loadFromPreferences() from the lg_service file
    // This method reads saved values (IP address, username, password, etc.) from local storage
    // 'await' pauses execution until the file is fully loaded
    // The result of calling this function is stored in the variable called savedModel
    // final means this variable can only be assigned ONCE and will not change

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      _usernameController.text = savedModel.username;
      // Sets the text value of the "username" input field to the saved username ('lg' by default)

      _ipController.text = savedModel.ip;
      // Sets the text value of the "ip" input field from the saved preferences ('192.168.0.100' in this case)

      _portController.text = savedModel.port.toString();
      // Sets the text value of the "port" input field to the saved port ('22' by default)

      _passwordController.text = savedModel.password;
      // Sets the text value of the "password" input field to the saved password ('lqgalaxy' by default)

      _screensController.text = savedModel.screens.toString();
      // Sets the text value of the "screens" input field to the saved number of screens ('5' by default)
    });
  }

  // ------------ dispose() ------------
  // Used to clean up resources
  // Called automatically when the widget is permanently removed from the widget tree
  // For example, when the app is closed or when the user navigates away from the screen

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the dispose() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  void dispose() {
    // It does not return anything (void)

    _usernameController.dispose();
    // Releases the resources held by the _usernameController variable
    // Without dispose(), this variable would continue to consume memory even after the widget is removed

    _ipController.dispose();
    // Releases the resources held by the _ipController variable
    // Without dispose(), this variable would continue to consume memory even after the widget is removed

    _portController.dispose();
    // Releases the resources held by the _portController variable
    // Without dispose(), this variable would continue to consume memory even after the widget is removed

    _passwordController.dispose();
    // Releases the resources held by the _passwordController variable
    // Without dispose(), this variable would continue to consume memory even after the widget is removed

    _screensController.dispose();
    // Releases the resources held by the _screensController variable
    // Without dispose(), this variable would continue to consume memory even after the widget is removed

    super.dispose();
    // super.dispose() calls the parent class dispose() method
    // It basically indicates Flutter to set up its own things first, and then we'll add our own things later
  }

  // ------------ saveCredentials() ------------
  // Used to store the user current connection settings (username, IP, port, password, number of screens) into local storage
  // Does NOT try to establish a connection
  // Even though connectToLG() also saves connection settings, it is important they are also saved on a separate function
  // This is so they are saved in case the connection attempt fails

  Future<void> _saveCredentials() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect, not to return data

    final credentials = LgConnectionModel(
      // Creates a new instance of the LgConnectionModel class (which comes from lg_service.dart)
      // Stores this instance in a variable called 'credentials'
      // final means this variable can only be assigned ONCE and will not change

      username: _usernameController.text,
      // Gives to "username" the value the user typed into the username field

      ip: _ipController.text,
      // Gives to "ip" the value the user typed into the ip field

      port: int.tryParse(_portController.text) ?? 22,
      // Gives to "port" the value the user typed into the port field
      // int.tryParse() converts a String to an int (a process called parsing)
      // If parsing fails, the fallback value (the value after ??) is used (22 in this case)

      password: _passwordController.text,
      // Gives to "password" the value the user typed into the password field

      screens: int.tryParse(_screensController.text) ?? 5,
      // Gives to "screens" the value the user typed into the screens field
      // int.tryParse() converts a String to an int (a process called parsing)
      // If parsing fails, the fallback value (the value after ??) is used (5 in this case)
    );

    await credentials.saveToPreferences();
    // Saves the user inputs (stored in "credentials") into local storage using the saveToPreferences() method
    // This allows the app to restore these values later, like it was done with the loadSavedSettings() method
    // 'await' pauses execution until the file is fully loaded

    final lgService = context.read<LgService>();
    // Access the current instance of LgService, which handles the LG connection logic
    // Stores this instance in a variable called "lgService"
    // final means this variable can only be assigned ONCE and will not change

    lgService.updateConnectionSettings(
      // Uses the updateConnectionSettings() method to update the credential values that were just saved
      // This makes sure the latest data is used and not just what is stored in the local preferences

      username: credentials.username,
      // Assigns to the "username" value the current username value that was stored in the "credentials" object

      ip: credentials.ip,
      // Assigns to the "ip" value the current ip value that was stored in the "credentials" object

      port: credentials.port,
      // Assigns to the "port" value the current port value that was stored in the "credentials" object

      password: credentials.password,
      // Assigns to the "password" value the current password value that was stored in the "credentials" object

      screens: credentials.screens,
      // Assigns to the "screens" value the current screens value that was stored in the "credentials" object
    );

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      const SnackBar(content: Text('Your credentials were saved!')),
      // In this case, it is a message to inform the user that their updated credentials were saved
    );
  }

  // ------------ connectToLG ------------
  // DOES TRY to establish a connection
  // Validates all form inputs, builds the settings model and saves it, updates the LG
  // Attempts a network connection retrying up to 5 times
  // Also saves the current connection settings, but is mainly focused on establishing a connection

  Future<void> _connectToLG() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (like establish a connection), not to return data

    if (!_formKey.currentState!.validate()) return;
    // '_formKey.currentState!.validate()' checks if all the fields in the form are valid
    // If any input is invalid, the function immediately exits (return)
    // The first ! makes sure that currentState is non-null

    setState(() => _isConnecting = true);
    // setState() updates the widget state
    // In this case, it updates it to show that a connection attempt is happening (_isConnecting = true)

    final connectionModel = LgConnectionModel(
      // Creates a new instance of the LgConnectionModel class (which comes from lg_service.dart)
      // Stores this instance in a variable called 'connectionModel'
      // final means this variable can only be assigned ONCE and will not change

      username: _usernameController.text,
      // Gives to "username" the value the user typed into the username field

      ip: _ipController.text,
      // Gives to "ip" the value the user typed into the ip field

      port: int.tryParse(_portController.text) ?? 22,
      // Gives to "port" the value the user typed into the port field
      // int.tryParse() converts a String to an int (a process called parsing)
      // The ?? operator is called the null-coalescing operator
      // It is used to provide a fallback value when something is null
      // If parsing fails, the fallback value (the value after ??) is used (22 in this case)

      password: _passwordController.text,
      // Gives to "password" the value the user typed into the password field

      screens: int.tryParse(_screensController.text) ?? 5,
      // Gives to "screens" the value the user typed into the screens field
      // int.tryParse() converts a String to an int (a process called parsing)
      // The ?? operator is called the null-coalescing operator
      // It is used to provide a fallback value when something is null
      // If parsing fails, the fallback value (the value after ??) is used (5 in this case)
    );

    await connectionModel.saveToPreferences();
    // Saves the user inputs (stored in "connectionModel") into local storage using the saveToPreferences() method
    // This allows the app to restore these values later, like it was done with the loadSavedSettings() method
    // 'await' pauses execution until the file is fully loaded

    final lgService = context.read<LgService>();
    // Access the current instance of LgService, which handles the LG connection logic
    // Stores this instance in a variable called "lgService"
    // final means this variable can only be assigned ONCE and will not change

    lgService.updateConnectionSettings(
      // Uses the updateConnectionSettings() method to update the credential values that were just saved
      // This makes sure the latest data is used and not just what is stored in the local preferences

      username: connectionModel.username,
      // Assigns to the "username" value the current username value that was stored in the "connectionModel" object

      ip: connectionModel.ip,
      // Assigns to the "ip" value the current ip value that was stored in the "connectionModel" object

      port: connectionModel.port,
      // Assigns to the "port" value the current port value that was stored in the "connectionModel" object

      password: connectionModel.password,
      // Assigns to the "password" value the current password value that was stored in the "connectionModel" object

      screens: connectionModel.screens,
      // Assigns to the "screens" value the current screens value that was stored in the "connectionModel" object
    );

    bool connected = false;
    // "connected" is a variable that keeps track of if the connection to the LG has been successful or not
    // Initializes the "connected" variable to false because, when the app first starts, there is no connection going on

    int retries = 0;
    // "retries" is a variable that keeps track of how many connecting attempts were made
    // It is initialized to 0

    while (!connected && retries < 5) {
      // This is a loop used to keep track of how many connection attemps were made
      // It goes on while the connection is NOT successful (!connected) AND while the number of retries are lower than 5 (retries < 5)
      // && means BOTH of these conditions have to be true for the loop to continue

      connected = await lgService.connectToLG() ?? false;
      // Calls lgService.connectToLG() to try to establish a connection
      // Stores the result in the "connected" variable
      // The ?? operator is called the null-coalescing operator
      // It is used to provide a fallback value when something is null
      // In this case, if the call returns null (maybe from an error or unexpected result), the fallback value used is false
      // This means that, if the call returns null, using the fallback value would mean that connected = false
      // 'await' pauses execution until the file is fully loaded

      if (!connected) {
        // If the connection was NOT successful (!connected)

        retries++;
        // Increases the current number of attempts by 1

        await Future.delayed(const Duration(seconds: 2));
        // Pauses the loop for 2 seconds before trying again
        // This helps to prevent immediate repeated retries
        // Future.delayed creates a Future (a value that will be available at some point in the future) that completes after a specified delay
        // const Duration(seconds: 2) specifies the length of that delay
        // 'await' pauses execution until the delay is over
      }
    }

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      _isConnecting = false;
      // In this case, it updates it to show that a connection attempt is NOT in the process of happening (_isConnecting = false)
      // This is because, if the conditions above were met, a connection HAS been established

      _isConnected = connected;
      // In this case, it updates it to show that a connection HAS been established (_isConnected = true)
    });

    if (!mounted) return;
    // In Flutter, "mounted" is a boolean value provided by the State class of a StatefulWidget
    // When a StatefulWidget is created and inserted into the widget tree, mounted = true
    // When the widget is removed from the tree (for example, the user navigates away from the screen), mounted = false
    // This property is read-only
    // If mounted = false, the function immediately exits (return)
    // In this context it means that, if the user exists the screen, no message of success/error in the connection is shown
    // Even if the success/error in the connection takes place
    // It only affects the showing of the message, not the connection per se

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      SnackBar(
        content: Text(
          connected
              // The message shown will depend on the value of the "connected" variable
              // This is decided using a ternary operator
              // A ternary operator works with the following structure:
              // condition ? valueIfTrue : valueIfFalse

              ? '✅ Successfully connected to the Liquid Galaxy!'
              // If the connection was successful (connected = true), it shows a message telling this to the user

              : '❌ Failed to connect to the Liquid Galaxy after $retries retries',
          // If the connection was NOT successful (connected = false), it shows a message telling this to the user
          // It also shows after how many attempts ($retries) the connection was NOT successful
        ),
      ),
    );
  }

  // ------------ disconnect ------------
  // Used to manage the disconnection from the Liquid Galaxy

  void _disconnect() {
    // It does not return anything (void)

    final lgService = context.read<LgService>();
    // Access the current instance of LgService, which handles the LG connection logic
    // Stores this instance in a variable called "lgService"
    // final means this variable can only be assigned ONCE and will not change

    lgService.disconnect();
    // Uses the disconnect() method to update the connection state that was just saved

    setState(() => _isConnected = false);
    // setState() updates the widget state
    // In this case, it updates it to show that a connection has NOT been established (_isConnected = false)

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      const SnackBar(
          content: Text('Successfully disconnected from the Liquid Galaxy')),
      // In this case, it is a message to inform the user that they were disconnected from the Liquid Galaxy
    );
  }

  // ------------ clearKML ------------
  // Used to clean KML files from a CONNECTED Liquid Galaxy system
  // KMLs are used to display geographic data
  // When you load a new KML, old visual elements may remain unless they are cleared
  // Clearing ensures the display is reset to a blank state before loading new data, preventing overlap
  // Clearing the KML is not AUTOMATIC in case you want to keep the KMLs that are already being displayed
  // But it is important that the user has this option

  Future<void> _clearKML() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data

    final lgService = context.read<LgService>();
    // Access the current instance of LgService, which handles the LG connection logic
    // Stores this instance in a variable called "lgService"
    // final means this variable can only be assigned ONCE and will not change

    if (!_isConnected) {
      // If there is NO connection already established (_isConnected = false)
      // Then this means that no KMLs are being displayed

      ScaffoldMessenger.of(context).showSnackBar(
        // Scaffold is a basic page layout that creates an structure for the screen
        // Shows a temporary message (a SnackBar) at the bottom of the screen

        const SnackBar(
            content: Text(
                'Not connected to Liquid Galaxy, so no KMLs can be cleared')),
        // In this case, it is a message to inform the user that they are not connected to Liquid Galaxy
        // And that they need to first be connected in order to clear KMLs
      );
      return;
      // If there is NO connection already established (_isConnected = false), the function immediately exits (return)
    }

    bool success = await lgService.cleanKML();
    // lgService.cleanKML() calls the cleanKML() method from lg_service.dart to proceed with clearing the KMLs
    // Stores the result of this call in the "success" variable

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      SnackBar(
        content: Text(success ? 'KMLs cleared!' : 'Failed to clear KMLs'),
        // The message shown will depend on the value of the "success" variable
        // This is decided using a ternary operator
        // A ternary operator works with the following structure:
        // condition ? valueIfTrue : valueIfFalse
        // If the KMLs were successfully cleared (success = true), it shows a message telling this to the user
        // If the KMLs were NOT successfully cleared (success = false), it shows a message telling this to the user
      ),
    );
  }

  // ------------ rebootLG ------------
  // Used to reboot the connection to LG
  // To reboot is basically to restart
  // In the LG context, it basically means to restart the master node and/or slave nodes of the LG rig
  // It checks if the system is connected and then tries to send the reboot command through the service layer

  Future<void> _rebootLG() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data

    final lgService = context.read<LgService>();
    // Access the current instance of LgService, which handles the LG connection logic
    // Stores this instance in a variable called "lgService"
    // final means this variable can only be assigned ONCE and will not change

    if (!_isConnected) {
      // If there is NO connection already established (_isConnected = false)
      // Then this means that no KMLs are being displayed

      ScaffoldMessenger.of(context).showSnackBar(
        // Scaffold is a basic page layout that creates an structure for the screen
        // Shows a temporary message (a SnackBar) at the bottom of the screen

        const SnackBar(
            content: Text(
                'Not connected to Liquid Galaxy, so a reboot cannot be done')),
        // In this case, it is a message to inform the user that they are not connected to Liquid Galaxy
        // And that, because of this, a reboot cannot be made (you cannot restart a connection that does not exist)
      );
      return;
      // If there is NO connection already established (_isConnected = false), the function immediately exits (return)
    }

    bool result = await lgService.reboot();
    // lgService.reboot() calls the reboot() method from lg_service.dart to proceed with the rebooting
    // Stores the result of this call in the "result" variable

    ScaffoldMessenger.of(context).showSnackBar(
      // Scaffold is a basic page layout that creates an structure for the screen
      // Shows a temporary message (a SnackBar) at the bottom of the screen

      SnackBar(
        content: Text(result
            ? 'Reboot command successfully sent'
            : 'Failed to reboot the Liquid Galaxy'),
        // The message shown will depend on the value of the "result" variable
        // This is decided using a ternary operator
        // A ternary operator works with the following structure:
        // condition ? valueIfTrue : valueIfFalse
        // If the reboot was successful (result = true), it shows a message telling this to the user
        // If the reboot was NOT successful (result = false), it shows a message telling this to the user
      ),
    );
  }

  // ---------------------- Reusable widget ----------------------
  // _buildTextField is a custom stateless widget that is used to display the different inputs of this screen
  // This is a reusable widget that we created to make the code more efficient

  Widget _buildTextField(
    String label,
    // Mandatory parameter
    // Variable called 'label' used to define the text that will appear in the form (for example, "Username")
    // It is a variable of the String type

    TextEditingController controller,
    // Mandatory parameters
    // Variable called 'controler' used to track and update the text value
    // It is a variable of the TextEditingController type
    // TextEditingController is a class that provides access to the current value of a TextField or TextFormField input

    {
    // The values inside {} are optional parameters

    bool isPassword = false,
    // Variable called 'isPassword' used to track the field that is used to write the password and hide it
    // We initialize it as false because most of the inputs are NOT passwords
    // So it is easier to just use this value in most inputs and change it only once when we are in the password input

    TextInputType keyboardType = TextInputType.text,
    // Variable called 'keyboardType' use to change the keyboard type
    // These keyboard types can be text, number, etc.
  }) {
    return Padding(
      // Wraps the form field inside a Padding widget to give it spacing

      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // Adds padding of 8 px on top and bottom
      // This is just the value I chose, you can use the value you want
      // If you wanted to add padding to all sides (top, bottom, left, right) you would use EdgeInsets.all(24.0);
      // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
      // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      // You can add padding on individual sides, for example:
      // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
      // EdgeInsets.only(left: 8.0, top: 10.0)

      child: TextFormField(
        // Actual form input field

        controller: controller,
        // Connects the TextFormField to a TextEditingController
        // In this case, the first "controller" is the parameter
        // And the second "controller" is the variable we created earlier

        obscureText: isPassword,
        // obscureText is a parameter that is used to hide the text
        // We connect it to the value of isPassword
        // If isPassword = true, this means the user will see something like ****** instead of the actual password when typing it
        // If isPassword = false, the user will see the password when typing it

        keyboardType: keyboardType,
        // Parameter used to set the type of on-screen keyboard that appears when the user taps the input field
        // In this case, the first "keyboardType" is the parameter
        // And the second "keyboardType" is the variable we created earlier

        decoration: InputDecoration(
          // decoration is a parameter used to style
          // In this case, it will be used to customize the look of the input field using InputDecoration()

          labelText: label,
          // 'labelText' displays a label above the text once the user interacts with the field
          // In this case, the label is displayed inside the input field
          // When the user clicks on the input field, it displays the label ABOVE the input field
          // In this case, we connect this parameter with the value of the "label" variable

          border: const OutlineInputBorder(),
          // Draws a rectangle (outlined) border around the text field
        ),
        validator: (value) {
          // The "validator" parameter is used to attach logic to validate the user input
          // In this case, it is called when the form is submitted using _formKey.currentState!.validate();
          // (value) { starts an anonymous function with just "value" (the current text in the input field) as a parameter
          // An anonymous function is a function without a name

          if (value == null || value.isEmpty) {
            // Checks if the field is null (value == null) or empty (value.isEmpty)
            // Uses the OR (||) operator for this

            return 'Required field';
            // If the field is null or empty, it lets the user know that they must write something in this field
          }
          if (keyboardType == TextInputType.number &&
              int.tryParse(value) == null) {
            // keyboardType == TextInputType.number means the field is expected to contain a number
            // int.tryParse(value) == null means the user entered something that is NOT a valid value
            // In this case, something that is not a number
            // int.tryParse(value) tries to convert the string input to a number
            // If it fails, it retuns null

            return 'Enter a number';
            // If this happens, a message is shown to let the user know that they must enter numbers, not text
          }
          return null;
          // This line means that all inputs are valid
        },
      ),
    );
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
    final settings = Provider.of<SettingsProvider>(context);
    // Access the current instance of SettingsProvider (a class from settings_provider.dart)
    // This class has information on the different font sizes for the text
    // Stores this instance in a variable called "settings"
    // final means this variable can only be assigned ONCE and will not change

    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('LG connection settings'),
        // Title displayed in the app bar

        backgroundColor: Colors.orange,
        // Background color of the app bar
        // I chose orange but you can choose any color you want
      ),
      body: SingleChildScrollView(
        // 'body' refers to the main content area of the screen
        // Wraps the content in a scrollable container, allowing to scroll vertically if it overflows
        // Useful when the content is really long and does not fit on the screen

        padding: const EdgeInsets.all(20),
        // Padding is used to add space around the button
        // Adds padding of 20 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: Form(
          // The Form widget is a container for grouping and managing multiple form fields

          key: _formKey,
          // Connects the Form to _formKey, allowing it to validate fields when needed using _formKey.currentState!.validate()

          child: Column(
            // Stacks widgets vertically

            children: [
              // List of child widgets that will be stacked vertically (in columns)

              // ---- INPUT FIELDS ----
              // ---- Username ----
              _buildTextField('Username', _usernameController),
              // _buildTextField is the reusable method we created earlier to generate input fields
              // In this case, it displays "Username" as the field label
              // And uses _usernameController to manage the actual input
              // Since no optional parameters (isPassword or keyboardType) are provided, it uses the default values
              // These are isPassword = false (text is visible) and keyboardType = TextInputType.text (text keyboard)

              // ---- IP ----
              _buildTextField('IP address', _ipController),
              // _buildTextField is the reusable method we created earlier to generate input fields
              // In this case, it displays "IP address" as the field label
              // And uses _ipController to manage the actual input
              // Since no optional parameters (isPassword or keyboardType) are provided, it uses the default values
              // These are isPassword = false (text is visible) and keyboardType = TextInputType.text (text keyboard)

              // ---- Port ----
              _buildTextField(
                'Port number',
                _portController,
                keyboardType: TextInputType.number,
              ),
              // _buildTextField is the reusable method we created earlier to generate input fields
              // In this case, it displays "Port number" as the field label
              // And uses _portController to manage the actual input
              // Since no value for the optional parameter isPassword is provided, it uses the default value
              // That is isPassword = false (text is visible)
              // However, it states that keyboardType = TextInputType.number
              // This means that, for this field, a numeric keyboard is used

              // ---- Password ----
              _buildTextField(
                'Password',
                _passwordController,
                isPassword: true,
              ),
              // _buildTextField is the reusable method we created earlier to generate input fields
              // In this case, it displays "Password" as the field label
              // And uses _passwordController to manage the actual input
              // Since no value for the optional parameter keyboardType is provided, it uses the default value
              // That is keyboardType = TextInputType.text (text keyboard)
              // However, it states that isPassword = true
              // This means that, for this field, the text is hided
              // This means that, when typing the password, instead of seeing, for example, "12345"
              // The user will see "*****"

              // ---- Screens ----
              _buildTextField(
                'Number of screens',
                _screensController,
                keyboardType: TextInputType.number,
              ),
              // _buildTextField is the reusable method we created earlier to generate input fields
              // In this case, it displays "Number of screens" as the field label
              // And uses _screensController to manage the actual input
              // Since no value for the optional parameter isPassword is provided, it uses the default value
              // That is isPassword = false (text is visible)
              // However, it states that keyboardType = TextInputType.number
              // This means that, for this field, a numeric keyboard is used

              const SizedBox(height: 24),
              // Adds vertical space between the title and the explanation
              // This is just an example value of 24 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- BUTTONS ----
              // ---- Saving the credentials ----
              ElevatedButton.icon(
                // Creates a button with an icon

                onPressed: _saveCredentials,
                // This line defines what happens when the user presses the button
                // In this case, it calls the _saveCredentials method we defined earlier

                icon: const Icon(Icons.save),
                // Icons.save is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a disk
                // You can choose other icons

                label: const Text('Save credentials'),
                // Text shown on the button
              ),
              const SizedBox(height: 12),
              // Adds vertical space between the title and the explanation
              // This is just an example value of 12 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- Connecting to LG ----
              ElevatedButton.icon(
                // Creates a button with an icon

                onPressed: _isConnecting ? null : _connectToLG,
                // This line defines what happens when the user presses the button
                // _isConnecting is the variable we created to track if a connection is being made
                // ? null : _connectToLG is the ternary operator, which chooses between two options depending on _isConnecting
                // These two options are 'null' or '_connectToLG' (a method we defined earlier)
                // A ternary operator works with the following structure:
                // condition ? valueIfTrue : valueIfFalse
                // This means that, in this case, if _isConnecting == true, onPressed = null
                // (if _isConnecting is true, there is a process to connect going on already, so there is no need to do anything)
                // And if _isConnecting == false, onPressed = _connectToLG
                // (if _isConnecting is false, there is no process trying to connet going on, so the connection may not have been made yet)

                icon:
                    // Text shown on the button
                    // In this case, it depends on the value of the "_isConnecting" value
                    // For this, it uses a ternary operator, which works with the following structure:
                    // condition ? valueIfTrue : valueIfFalse
                    _isConnecting
                        ? const SizedBox(
                            // If _isConnecting = true, it shows an icon with the following characteristics:

                            height: 16,
                            // A height of 16 px

                            width: 16,
                            // A width of 16 px

                            child: CircularProgressIndicator(
                              // CircularProgressIndicator is a built-in Flutter widget that shows a spinning circular loading animation
                              // It is displayed as the icon in this case

                              strokeWidth: 2.0,
                              // 'strokeWidth' controls how thick the spinner arc is
                              // You can choose any value you want, but it usually oscillates between 1.0 (very thin) and 10.0 (very thick)

                              color: Colors.white,
                              // 'color' controls the color of the spinner
                              // I chose white but you can choose whatever color you want
                            ),
                          )
                        : const Icon(Icons.link),
                // If _isConnecting = false, it shows Icons.link as an icon
                // Icons.link is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a chain
                // You can choose other icons

                label: Text(
                    // Text shown on the button
                    // In this case, it depends on the value of the "_isConnecting" value
                    // For this, it uses a ternary operator, which works with the following structure:
                    // condition ? valueIfTrue : valueIfFalse
                    _isConnecting
                        ? 'Connecting...'
                        // If _isConnecting = true, the text shown is "Connecting..."
                        // This makes sense because _isConnecting = true means a connection attempt is going on

                        : _isConnected
                            // If _isConnecting = true, the text shown depends on the "_isConnected" value

                            ? 'Reconnect'
                            // If _isConnected = true, the text shown is "Reconnect"
                            // This makes sense because _isConnected = true means a connection has been established, so we can try to reconnect

                            : 'Connect to the Liquid Galaxy'
                    // If _isConnected = false, the text shown is "Connect to the Liquid Galaxy"
                    // This makes sense because _isConnected = false means a connection has NOT been established
                    // So the onñy thing we can do is try and establish one
                    ),
              ),
              const SizedBox(height: 12),
              // Adds vertical space between the title and the explanation
              // This is just an example value of 12 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- Clearing KMLs ----
              ElevatedButton.icon(
                // Creates a button with an icon

                onPressed: _isConnected ? _clearKML : null,
                // This line defines what happens when the user presses the button
                // _isConnected is the variable we created to track if a connection HAS been made
                // ? _clearKML : null is the ternary operator, which chooses between two options depending on _isConnected
                // These two options are '_clearKML' (a method we defined earlier) or 'null'
                // A ternary operator works with the following structure:
                // condition ? valueIfTrue : valueIfFalse
                // This means that, in this case, if _isConnected == true, onPressed = _clearKML
                // (if _isConnected is true, a connection has been established, so there are KMLs that we can clean)
                // And if _isConnected == false, onPressed = null
                // (if _isConnected is false, a connection has NOT been established, so there are NO KMLs that we can clean)

                icon: const Icon(Icons.cleaning_services),
                // Icons.cleaning_services is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a broom
                // You can choose other icons

                label: const Text('Clear KMLs'),
                // Text shown on the button
              ),
              const SizedBox(height: 12),
              // Adds vertical space between the title and the explanation
              // This is just an example value of 12 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- Reboot the LG connection ----
              ElevatedButton.icon(
                // Creates a button with an icon

                onPressed: _isConnected ? _rebootLG : null,
                // This line defines what happens when the user presses the button
                // _isConnected is the variable we created to track if a connection HAS been made
                // ? _rebootLG: null is the ternary operator, which chooses between two options depending on _isConnected
                // These two options are '_rebootLG' (a method we defined earlier) or 'null'
                // A ternary operator works with the following structure:
                // condition ? valueIfTrue : valueIfFalse
                // This means that, in this case, if _isConnected == true, onPressed = _rebootLG
                // (if _isConnected is true, a connection has been established, so we can try to reboot)
                // And if _isConnected == false, onPressed = null
                // (if _isConnected is false, a connection has NOT been established, so there is no connection going on that we can try to reboot)

                icon: const Icon(Icons.restart_alt),
                // Icons.restart_alt is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a restart circle
                // You can choose other icons

                label: const Text('Reboot the Liquid Galaxy connection'),
                // Text shown on the button
              ),
              const SizedBox(height: 12),
              // Adds vertical space between the title and the explanation
              // This is just an example value of 12 px, you can use any value you want
              // This is just an aesthetic choice

              // ---- Disconnect from the LG ----
              ElevatedButton.icon(
                // Creates a button with an icon

                onPressed: _isConnected ? _disconnect : null,
                // This line defines what happens when the user presses the button
                // _isConnected is the variable we created to track if a connection HAS been made
                // ? _disconnect: null is the ternary operator, which chooses between two options depending on _isConnected
                // These two options are '_disconnect' (a method we defined earlier) or 'null'
                // A ternary operator works with the following structure:
                // condition ? valueIfTrue : valueIfFalse
                // This means that, in this case, if _isConnected == true, onPressed = _disconnect
                // (if _isConnected is true, a connection has been established, so we can try to disconnect)
                // And if _isConnected == false, onPressed = null
                // (if _isConnected is false, a connection has NOT been established, so there is no connection going on that we can try to disconnect from)

                icon: const Icon(Icons.link_off),
                // Icons.link_off is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a broken chain
                // You can choose other icons

                label: const Text('Disconnect from the Liquid Galaxy'),
                // Text shown on the button
              ),
            ],
          ),
        ),
      ),
    );
  }
}
