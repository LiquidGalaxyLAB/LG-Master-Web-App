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

