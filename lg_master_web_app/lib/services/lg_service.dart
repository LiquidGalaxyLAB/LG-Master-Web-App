/*
// -------------------------------------------- LIQUID GALAXY SERVICE --------------------------------------------
// This file contains the logic related to connecting to a Liquid Galaxy setup
// As of right now it is a dummy version (it does not really work, is a simulation)
// Will be updated with real networking logic later!!

// ---------------------- Import packages ----------------------
import 'dart:async'; // Imports the Dart asynchronous tools

// ---------------------- LgService widget ----------------------
// LgService class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// This class contains methods to interact with the Liquid Galaxy
// Right now it only contains one mock method that simulates a connection

class LgService {
  // ---------------------- Simulated connection logic ----------------------
  Future<bool> connectToLG({String ip = '', int port = 22}) async {
    // This is an asynchronous method that returns a Future<bool>
    // 'async' means that the method waits for certain operations to be completed without blocking the rest of the app
    // 'Future' indicates the method does not have a value YET but it will have it (in this case that value is a boolean)
    // It tries to connect to a Liquid Galaxy system using an IP address and port number
    // If the connection is successful it returns true
    // If not, it returns false

    await Future.delayed(const Duration(seconds: 2));
    // Simulates network delay or connection time, 2 seconds in this case
    // This is just to make the connection feel more realistic to the user (again, this is a simulation)

    // ---------------------- Dummy connection check ----------------------
    if (ip == '127.0.0.1' && port == 22) {
      // If the user enters exactly this IP and port we consider it a successful connection
      return true;
    } else {
      return false;
      // If not, it will count as if the connection failed
    }
  }

  // ----------------- TO ADD TO MAKE IT WORK FOR REAL -----------------
  // SSH or network connections
  // Saving IP and port info locally
  // Disconnect option (maybe not here but in the settings file)
  // Reconnection retries (maybe not here but in the settings file)
}
*/

// -------------------------------------------- LIQUID GALAXY SERVICE --------------------------------------------
// This file contains the logic related to connecting to a Liquid Galaxy setup via SSH

// ---------------------- Import packages ----------------------
import 'dart:io'; // Used for handling socket exceptions and network errors
import 'dart:convert'; // For coding and decoding JSON
import 'package:dartssh2/dartssh2.dart'; // SSH package used to connect to and send commands to the Liquid Galaxy
// IMPORTANT!! Add this also in pubspec.yaml

// ---------------------- Connection to the Liquid Galaxy ----------------------
class LgService {
  // Makes sure there is only one instance of LgService across the whole app (which is called singleton pattern)
  // Useful to manage a SINGLE connection or state across different parts of the app

  LgService._internal();
  // Private constructor (_), only accessible from within the class
  // Prevents creating multiple instances from outside the class

  static final LgService _instance = LgService._internal();
  // This line creates and stores the single instance of the LgService class
  // 'static' means it belongs to the class itself, NOT to an object
  // 'final' means it cannot be reassigned after being initialized

  factory LgService() => _instance;
  // Instead of creating a new object, it returns the existing _instance that was created earlier
  // This enforces the Singleton behavior by always returning the same object

  // -------- SSH client and connection details --------
  SSHClient? _client;
  // The private variable _client will store the active SSH connection
  // ? means it can be null if there is no current connection

  String mainNodeIP = '127.0.0.1';
  // IP address of the main node of the Liquid Galaxy system
  // In this case I used this one to establish a dummy connection

  int port = 22;
  // Default SSH port
  // This is just the port I chose, can be other numbers too

  String username = 'lg';
  // Default LG username used to log into the Liquid Galaxy system via SSH
  // Can be anything you want bubt this is the easiest option

  String password = 'lg';
  // Default LG password used to log into the Liquid Galaxy system via SSH
  // Can be anything you want bubt this is the easiest option

  // -------- Attempt connection to LG --------
  Future<bool> connectToLG() async {
    // 'async' allows to use 'await' inside the function
    // Future<bool> means the result will be either true or false

    try {
      // Block to catch any errors that might happen during execution

      final socket = await SSHSocket.connect(mainNodeIP, port);
      // Tries to establish a connection to the LG system by opening a socket using the given IP and port
      // 'await' pauses execution until connection is successful or fails

      _client = SSHClient(
        // If the socket connects, creates an SSH client with the login credentials to manage the SSH session
        socket,
        username: username,
        // Username defined earlier ('lg' in this case)

        onPasswordRequest: () => password,
        // Function used to ask for the password when requested during authentication
      );

      return true;
      // Return true if successfully connected
    } on SocketException catch (e) {
      // Catches if there is a network-level problem (server unreachable, wrong IP or port, etc.)

      print('Socket connection failed: $e');
      // Prints the error and returns false
      // NOT SHOWN TO THE USER, only in the debug console

      return false;
    } on SSHAuthError catch (e) {
      // Catches if the authentication fails (wrong username/password)

      print('SSH authentication failed: $e');
      // Prints the error and returns false
      // NOT SHOWN TO THE USER, only in the debug console

      return false;
    } catch (e) {
      // Catches any other errors not already handled above

      print('Unknown connection error: $e');
      // Prints the error and returns false
      // NOT SHOWN TO THE USER, only in the debug console
      return false;
    }
  }

  // -------- Disconnect from LG --------
  // Method defined to terminate the SSH connection to the Liquid Galaxy
  void disconnect() {
    _client?.close();
    // Closes the SSH connection if it exists
    // ? means that close() will only be called if _client is not null
    // In other words, it will only be called if a connection exists

    _client = null;
    // Clears the client variable

    print('Disconnected from the Liquid Galaxy');
    // Prints this message in the debug console
    // NOT SHOWN TO THE USER
  }

  // -------- Send a command to the LG via SSH --------
  // Run a basic command with proper stdout (standard output)/stderr (standard error output) decoding
  // Includes the management of errors

  Future<bool> execute(String command) async {
    // 'async' allows to use 'await' inside the function
    // The 'command' parameter is the command we want to send
    // Future<bool> means the result will be either true or false

    try {
      // Block to catch any errors that might happen during execution
      // In this case it checks if there is a connection before trying to send the command

      if (_client == null) {
        // Checks if the SSH connection (_client) exists
        // If it is null, there is no active connection

        print('Client not connected');
        // Prints the error and returns false
        // NOT SHOWN TO THE USER, only in the debug console
        return false;
      }

      final session = await _client!.execute(command);
      // Creates an SSH session and sends the command to the LG using the execute method of the SSH client
      // ! is a null check that forces Dart to treat _client as non null
      // 'await' pauses execution until connection is successful or fails

      final output =
          await session.stdout.cast<List<int>>().transform(utf8.decoder).join();
      // Reads standard output bytes from the server (stdout) and converts them into readable text
      // 'await' pauses execution until connection is successful or fails

      final errorOutput =
          await session.stderr.cast<List<int>>().transform(utf8.decoder).join();
      // Reads standard error output bytes from the server (stderr) and converts them into readable text
      // 'await' pauses execution until connection is successful or fails

      if (output.isNotEmpty) print('Output:\n$output');
      // Checks if the standard output is not empty
      // \n adds a line break
      // If it is not empty, it prints the output in the debug console
      // NOT SHOWN TO THE USER

      if (errorOutput.isNotEmpty) print('Error:\n$errorOutput');
      // Checks if the standard error output is not empty
      // \n adds a line break
      // If it is not empty, it prints the output in the debug console
      // NOT SHOWN TO THE USER

      return true;
    } catch (e) {
      // Catches any other errors not already handled above

      print('Command execution failed: $e');
      // Prints the error and returns false
      // NOT SHOWN TO THE USER, only in the debug console
      return false;
    }
  }

  // -------- Clear KML layers --------
  Future<bool> cleanKMLsAndVisualization() async {
    // 'async' allows to use 'await' inside the function
    // Future<bool> means the result will be either true or false

    final result = await execute(
        // 'await execute()' calls the execute method to send a command over SSH and waits for the result

        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt'
        // This is a Linux command
        // echo "exittour=true"
        // This writes exittour=true into a special file that LG monitors, forcing any active tour to stop
        // A tour is an automated camera movement
        // > /tmp/query.txt
        // This redirects the printed string to the file /tmp/query.txt
        // If the file exists, it is overwritten
        // LG reads commands from this file, so writing exittour=true here means sending a stop command
        // &&
        // Logical AND operator
        // Indicates to only do the next command if the first one succeeds
        // This makes sure the KML file is only cleared if stopping the tour worked
        // > /var/www/html/kmls.txt
        // Shortcut to empty the file kmls.txt
        // Clears the kmls.txt file by overwriting it with nothing
        // This file usually holds references to the KML layers being shown
        // This means that clearing it removes all KML visualizations from the globe
        );
    // This is used to reset the visual state of the Liquid Galaxy
    return result;
  }

  // -------- Reboot all screens --------
  // Thought for 5 screens
  Future<bool> rebootAllScreens() async {
    List<String> nodeIPs = [
      // List of IP addresses
      // Each IP represents a node

      '127.0.0.1', // lg1 (main node) (dummy IP)
      '127.0.0.2', // lg2 (dummy IP)
      '127.0.0.3', // lg3 (dummy IP)
      '127.0.0.4', // lg4 (dummy IP)
      '127.0.0.5', // lg5 (dummy IP)
    ];

    bool allSuccess = true;
    // This variable stores in ALL the nodes are rebooted successfully
    // If ANY reboot fails, it will be set to false

    // ---- Iterating thorugh every node on the list ----
    for (String nodeIP in nodeIPs) {
      try {
        // Block to catch any errors that might happen during execution

        final socket = await SSHSocket.connect(nodeIP, port);
        // Attempts to open a TCP socket connection to the current node IP on the SSH port
        // 'await execute()' calls the execute method to send a command over SSH and waits for the result

        final client = SSHClient(
          // If the socket connects, creates an SSH client with the login credentials to manage the SSH session

          socket,
          username: username,
          // Username defined earlier ('lg' in this case)

          onPasswordRequest: () => password,
          // Function used to ask for the password when requested during authentication
        );

        // ---- Send the reboot command ----
        final session = await client.execute('echo $password | sudo -S reboot');
        // Sends a command to the node via SSH to reboot the machine
        // echo $password outputs the password as text
        // | takes the output of 'echo $password' and passes it as input to 'sudo -S reboot'
        // sudo -S reboot runs the reboot command as a superuser (root)
        // The -S option tells sudo to read the password from standard input (stdin) instead of trying to prompt interactively
        // Prompt interactively means the program asks you to manually type something
        // Waits for the command session to start

        final output = await session.stdout
            // Reads the standard output (stdout) from the reboot command
            // The result will be stored in the variable output

            .cast<List<int>>()
            // Converts the data stream into a stream of lists of integers (List<int>) that represent raw bytes

            .transform(utf8.decoder)
            // Decodes the stream of bytes into a stream of strings, interpreting the bytes as UTF-8 encoded text
            // This means that we now have readable text instead of raw bytes

            .join();
        // Combines the entire output into one string

        final errorOutput = await session.stderr
            // Reads the standard error (stderr) output from the reboot command
            // The result will be stored in the variable errorOutput

            .cast<List<int>>()
            // Converts the data stream into a stream of lists of integers (List<int>) that represent raw bytes

            .transform(utf8.decoder)
            // Decodes the stream of bytes into a stream of strings, interpreting the bytes as UTF-8 encoded text
            // This means that we now have readable text instead of raw bytes

            .join();
        // Combines the entire output into one string

        if (output.isNotEmpty) {
          // If the stdout is not empty, prints the output to the console
          // NOT VISIBLE TO THE USER
          print('[$nodeIP] Output:\n$output');
        }

        if (errorOutput.isNotEmpty) {
          // If the stderr is not empty, prints the error output
          // NOT VISIBLE TO THE USER
          print('[$nodeIP] Error:\n$errorOutput');
        }

        client.close();
        // Closes the SSH connection to release resources
        // This is important to do in order to avoid leaving open connections
      } catch (e) {
        // Catches any errors during the connection or command execution

        print('Failed to reboot $nodeIP: $e');
        // Prints an error message specifying which node failed and why
        // NOT VISIBLE TO THE USER

        allSuccess = false;
        // Since the node reboot failed, marks allSuccess as false
      }
    }

    return allSuccess;
    // Returns true if all nodes rebooted successfully, returns false if ANY of them failed
  }

  // -------- Update credentials --------
  // May not be necessary, check if the username and password can always be the same to avoid complications
  void updateCredentials(
      // Method that allows to change the SSH username and password at runtime, without creating a new instance

      {required String newUser,
      required String newPassword})
  // Defines the two parameters that the method requires
  // In this case, newUser and newPassword

  {
    username = newUser;
    // Updates the stored username with a new one

    password = newPassword;
    // Updates the stored password with a new one

    print('Updated credentials');
    // NOT SHOWN TO THE USER
  }

  bool isConnected() => _client != null;
  // Returns true if the connection is active
  // Returns false if the connection is not active (if _client = null)
}
