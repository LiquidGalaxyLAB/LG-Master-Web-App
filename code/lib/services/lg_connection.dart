import 'package:ssh2/ssh2.dart'; // Imports the ssh2 package
                                 // This allows the connection to remote servers via SSH and safely transfer files

class LGService {
  late SSHClient _client;  // Declares a private variable called '_client' of the type 'SSHClient'
                           // SSHClient needs parameters like host, username, or password that it does not have right now
                           // 'late' indicates to Dart that it will be initialized later, so it won't be treated as 'null'
  
  LGService();   // Default constructor for LGService class

  void init({
    // These parameters specify the SSH connection details
    required String host,
    required int port,
    required String username,
    required String password,
  }) {
    // Creates an SSH client with the connection parameters from the init method
    // Then assigns this client to the _client variable that was declare earlier
    // This setsn up the SSH client so it is ready to connect to the remote server
    _client = SSHClient(
      host: host,
      port: port,
      username: username,
      passwordOrKey: password,
    );
  }

  // Attempts to establish an SSH connection asynchronously
  // The connect method y asynchronous because establishing an SSH connection takes a lot of time
  // If it was done synchronously, it would block the main thread of the application, causing the app to freeze while waiting for the connection
  // By making the method asynchronous, the app can run other tasks while the connection is being established
  Future<bool> connect() async {
    // Starts a try block to catch any errors that might happen while trying to connect
    try {
      // Calls the connect method on the SSH client and waits for the result
      String? result = await _client.connect();
      // Returns true if the connection was successful
      return result == "session_connected";
    } catch (e) {
      // Handle connection error
      // Returns false indicating connection failure
      return false;
    }
  }

  // Disconnects the SSH client asynchronously
  Future<void> disconnect() async {
    await _client.disconnect();
  }

  // Executes a command on the remote SSH server asynchronously
  // 'Future<String?>' means that it will be eventually complete with either a String (the command output) or null (if something goes wrong)
  Future<String?> executeCommand(String command) async {
    try {
      // Returns the command output as a string
      return await _client.execute(command);
    } catch (e) {
      // Handle any error that takes place during command execution
      // Returns null if execution fails
      return null;
    }
  }
}

