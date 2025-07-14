// -------------------------------------------- CONNECTION SCREEN --------------------------------------------
// This is the screen where the user will introduce the IP and the port related to the Liquid Galaxy

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import '../../services/lg_service.dart'; // Imports the service screen, which handles the logic to connect to the Liquid Galaxy screen
import 'connection_status_screen.dart'; // Imports the status screen, which displays the result of the connection attempt

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
  // In this case, we are replacing the initState() method that comes from Flutter's State class
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
  final _formKey = GlobalKey<FormState>();
  // GlobalKey<FormState>() creates a key (an unique identifier) to be used by the 'Form' widget (used later in this file)
  // With '_formKey' we can call '_formKey.currentState!.validate()' to check if all the field in the form are valid
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _ipController = TextEditingController();
  // _ipController is a variable used to manage the input for the IP
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  final _portController = TextEditingController();
  // _portController is a variable used to manage the input for the port
  // _ means its private, in this case is useful because it means that no other file can modify or access it by accident

  bool _isLoading = false;
  // _isLoading is a variable used to track if a connection is being made
  // _ means its private, in this case is useful to avoid interference from other components

  // ------------- Connect method -------------
  Future<void> _onConnect() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    if (!_formKey.currentState!.validate()) return;
    // This line checks whether the form inut is valid (in this case, if the IP and port field are filled correctly)

    setState(() => _isLoading = true);
    // This line disables the 'Connect' button and shows a loading spinner

    final ip = _ipController.text;
    final port = int.tryParse(_portController.text) ?? 0;

    // Crear instancia de LgService
    LgService lgService = LgService();
    lgService.mainNodeIP = ip;
    lgService.port = port;

    final success = await lgService.connectToLG();
    // Calls the connectToLG method from the lg_service.dart file
    // 'await' pauses execution until the connection attempt finishes
    // Stores the result in the 'success' variable
    // The connectToLG method has two arguments, ip and port
    // This line specifies that the value for the 'ip' parameter is the ip the user introduced
    // and that the value for the 'port' parameter is the port the user introduced

    setState(() => _isLoading = false);
    // This line hides the loading spinner and re-enables the connection button

    Navigator.push(
      // In this case, it navigates to the connection status screen when tapping the 'Connect' button
      // The screen that will be seen is managed by connection_status_screen.dart depending on if it has been successful or not
      // Navigator.push adds a new screen (it transitions to a new page)
      // It also remembers the previous screen so the user can go back using the 'back' button

      context,
      // 'context' represents the location of the current widget in the widget tree
      // Flutter uses it to know where to place the new screen in the navigation hierarchy

      MaterialPageRoute(
        // MaterialPageRoute is used to create a page transition animation

        builder: (_) => ConnectionStatusScreen(
          // ConnectionStatusScreen is the class associated to the connection status screen

          ipAddress: ip,
          // Passes the 'ip' (from the input field) to the parameter 'ipAddress' from ConnectionStatusScreen
          // This allows the next screen to use and display the entered IP address

          port: port,
          // Passes the 'port' (from the input field) to the parameter 'port' from ConnectionStatusScreen
          // This allows the next screen to use and display the entered port number

          isConnected: success == true,
          // If the connection result (stored in 'success') is successful (true), passes the result as a bool to the isConnected parameter
        ),
      ),
    );
  }

  @override
  // Overrides the dispose() method from the State class

  void dispose() {
    // Declares the dispose method, cleaning up any resources used by the widget

    _ipController.dispose();
    // Calls the dispose() method on _ipController, which was used for the input field to get the ip address
    // This frees up memory and removes listeners attached to the controller

    _portController.dispose();
    // Calls the dispose() method on _portController, which was used for the input field to get the port number
    // This frees up memory and removes listeners attached to the controller

    super.dispose();
    // Calls the parent's class dispose method, which makes sure any cleanup defined in the base State is also done
    // It is important to call this last in the override to avoid unexpected issues
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

        title: const Text('Connection'),
        // Title displayed in the app bar

        backgroundColor: Colors.orange,
        // Background color of splash screen, in this example is set to orange
        // You can choose the color you want
      ),

      body: Center(
        // 'body' refers to the main content area of the screen
        // 'Center' places everything in the middle of the screen
        // This widget stacks its children vertically and centers them

        child: Padding(
          // Padding is used to add space around the button

          padding: const EdgeInsets.all(24.0),
          // Adds padding of 24 px to all sides (top, bottom, left, right)
          // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
          // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
          // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          // You can add padding on individual sides, for example:
          // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
          // EdgeInsets.only(left: 8.0, top: 10.0)

          child: Form(
            key: _formKey,
            // Connects the Form to _formKey, allowing it to validate fields when needed using _formKey.currentState!.validate()

            child: Column(
                // Stacks widgets vertically

                mainAxisSize: MainAxisSize.min,
                // Only take as much vertical space as needed (the minimum space needed)

                children: [
                  // List of child widgets that will be stacked vertically

                  // ------- IP address input field -------
                  TextFormField(
                    controller: _ipController,
                    // Connects the text field to _ipController to read and write the input related to the IP address

                    decoration: const InputDecoration(labelText: 'IP Address'),
                    // Adds the label 'IP Address' inside the input box
                    // This is to indicate the user where to write the IP address

                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Enter IP' : null,
                    // Validates the input
                    // If left empty, shows 'Enter IP', this is again to indicate the user where to write the IP address
                  ),
                  const SizedBox(height: 16),
                  // Adds vertical space between the icon and the text
                  // This is just an example value of 16 px, you can use any value you want
                  // This is just an aesthetic choice

                  // ------- Port input field -------
                  TextFormField(
                    controller: _portController,
                    // Connects the text field to _portController to read and write the input related to the port number

                    decoration: const InputDecoration(labelText: 'Port'),
                    // Adds the label 'Port' inside the input box
                    // This is to indicate the user where to write the Port number

                    keyboardType: TextInputType.number,
                    // Opens the numeric keyboard for easier number input

                    validator: (v) => (v == null || int.tryParse(v) == null)
                        // Makes sure the input is not empty and is a valid number
                        // int.tryParse(v) == null attempts to convert the string v into an integer
                        ? 'Enter valid port' // If the input is invalid, it will show this message
                        : null, // If the input is valid, it returns null (no error)
                  ),

                  const SizedBox(height: 24),
                  // Adds vertical space between the icon and the text
                  // This is just an example value of 24 px, you can use any value you want
                  // This is just an aesthetic choice

                  // ------- Connect button -------
                  ElevatedButton(
                    // Creates a button

                    onPressed: _isLoading ? null : _onConnect,
                    // This line defines what happens when the user presses the button
                    // _isLoading is the variable we created to track if a connection is being made
                    // ? null : _onConnect is the ternary operator, which chooses between two options depending on _isLoading
                    // These two options are 'null' or '_onConnect'
                    // A ternary operator works with the following structure:
                    // condition ? valueIfTrue : valueIfFalse
                    // This means that, in this case, if _isLoading == true, onPressed = null
                    // And if _isLoading == false, onPressed = _onConnect

                    style: ElevatedButton.styleFrom(
                      // Customizes the appeareance of the button

                      backgroundColor: Colors.orange,
                      // Sets the button color to orange
                      // You can choose the color you want

                      foregroundColor: Colors.white,
                      // Sets the spinner button (indicating loading) to white
                      // You can choose the color you want
                    ),

                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Connect'),
                    // Uses a ternary operator to decide what widget to display as the child of the ElevatedButton
                    // A ternary operator works with the following structure:
                    // condition ? valueIfTrue : valueIfFalse
                    // This means that, in this case, if _isLoading == true, it means it is trying to establish a connection with the Liquid Galaxy
                    // It shows a loading spinner (CircularProgressIndicator), this spinner is set to be white but you can adjust it to your liking
                    // If _isLoading == false, it is not in the process of connecting, so it shows the text 'Connect'
                    // This indicates the user they can tap on the button to try to establish a connection
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
