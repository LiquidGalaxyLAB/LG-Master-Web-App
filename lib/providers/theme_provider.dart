// -------------------------------------------- SETTINGS PROVIDER --------------------------------------------
// File used to change the theme (dark or light)

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:shared_preferences/shared_preferences.dart'; // Imports a package used for saving data locally (key-value pairs) on the device

class ThemeProvider with ChangeNotifier {
  // ThemeProvider extends ChangeNotifier so that the widgets can listen for changes

  bool _isDarkMode = false;
  // The private variable _isInitialized tracks if the current mode of the app is dark or not
  // Its default value is false because when the default mode of the app is light

  bool _isInitialized = false;
  // The private variable _isInitialized tracks if the provider has finished loading the saved font size
  // Its default value is false because when the app first starts, it has NOT loaded any saved settings yet

  bool get isDarkMode => _isDarkMode;
  // Defines a getter named isDarkMode
  // A getter is a special method that allows to easily access the value of a property as if it was a simple variable
  // In this case it allows ONLY read access to the private variable _isDarkMode from outside the class

  bool get isInitialized => _isInitialized;
  // Defines a getter named isInitialized
  // A getter is a special method that allows to easily access the value of a property as if it was a simple variable
  // In this case it allows ONLY read access to the private variable _isInitialized from outside the class

  ThemeProvider() {
    // Constructor for the ThemeProvider class

    _loadTheme();
    // _loadTheme() is a method that of loads (restores) the previously saved theme mode (dark/light) from local storage
    // Local storage = SharedPreferences
  }

  // -------- toggleTheme method --------
  // Used to change the theme when tapping on the button from the settings screen

  void toggleTheme(bool isOn) {
    // Defines a method that does not return any value (void)
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data
    // Takes a bool variable called "isOn" as a parameter
    // "isOn" indicates if dark mode should be on (true) or off (false)

    _isDarkMode = isOn;
    // Sets the value of the _isDarkMode variable to the value of "isOn"
    // This reflects the choice of the user

    _saveTheme(isOn);
    // _saveTheme is a method that saves the user dark/light choice to local device storage
    // This way, it will be remembered next time the app starts

    notifyListeners();
    // Notifies all widgets or listeners that depend on this provider that something has changed
  }

  // -------- loadTheme method --------
  // Used to load the theme choice from local storage

  Future<void> _loadTheme() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    // prefs.getBool('isDarkMode') tries to read a boolean value from SharedPreferences under the key 'isDarkMode'
    // In other words, it loads the dark mode setting from local storage
    // If nothing was saved before (it returns null), it returns false as the default value (it returns light as the default value)
    // This is because of the ?? (null-aware operator)
    // The result is stored in the _isDarkMode variable

    _isInitialized = true;
    // The private variable _isInitialized tracks if the provider has finished loading the saved font size
    // Now is set to true because the loading process has already been finished

    notifyListeners();
    // Notifies all widgets or listeners that depend on this provider that something has changed
  }

  // -------- saveTheme method --------
  // Used to save the current theme choice

  Future<void> _saveTheme(bool value) async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data
    // Takes a bool variable called vañue as a parameter

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    await prefs.setBool('isDarkMode', value);
    // 'await' pauses execution until the file is fully loaded
    // prefs.setBool('isDarkMode', value) stores the "value" in SharedPreferences with the key 'isDarkMode'
    // This saves the current dark mode choice to local storage
  }
}
