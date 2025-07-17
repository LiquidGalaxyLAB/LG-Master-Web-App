// -------------------------------------------- SETTINGS PROVIDER --------------------------------------------
// File used to change the sizes of the text fonts

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:shared_preferences/shared_preferences.dart'; // Imports a package used for saving data locally (key-value pairs) on the device

class SettingsProvider extends ChangeNotifier {
  // SettingsProvider extends ChangeNotifier so that the widgets can listen for changes

  String _fontSize = 'Medium';
  // _fontSize is a private variable that holds the current font size choice
  // It is initialized to 'Medium' because this is the default value chosen

  double get fontSizeValue {
    // Defines a getter named fontSizeValue
    // A getter is a special method that allows to easily access the value of a property as if it was a simple variable
    // Flutter uses double for font size and scaling

    switch (_fontSize) {
      // Begins a switch that checks the value of _fontSize

      case 'Small':
        // If _fontSize = 'Small'

        return 14.0;
      // It retuns 14.0
      // This means that, with the Small option, the font size will be 14 px

      case 'Large':
        // If _fontSize = 'Large'

        return 22.0;
      // It retuns 22.0
      // This means that, with the Large option, the font size will be 22 px
      default:
        // The default _fontSize value ('Medium', in this case)

        return 17.0;
      // It retuns 17.0
      // This means that, with the Medium (or default) option, the font size will be 17 px
    }
  }

  String get fontSize => _fontSize;
  // Defines a getter named fontSize
  // A getter is a special method that allows to easily access the value of a property as if it was a simple variable
  // In this case it allows ONLY read access to the private variable _fontSize from outside the class

  bool _isInitialized = false;
  // The private variable _isInitialized tracks if the provider has finished loading the saved font size
  // Its default value is false because when the app first starts, it has NOT loaded any saved settings yet

  bool get isInitialized => _isInitialized;
  // Defines a getter named isInitialized
  // A getter is a special method that allows to easily access the value of a property as if it was a simple variable
  // In this case it allows ONLY read access to the private variable _isInitialized from outside the class

  SettingsProvider() {
    // Constructor for the SettingsProvider class

    _loadFromPrefs();
    // _loadFromPrefs() is a method that loads the previously saved font size from local storage
    // Doing this at construction means the provider always tries to restore saved preferences as soon as it is created
  }

  // -------- setFontSize method --------
  // Used to apply the changes to the font size

  void setFontSize(String size) async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data

    _fontSize = size;
    // Updates the _fontSize variable with the value of "size" (the only parameter that the function takes)

    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    await prefs.setString('fontSize', size);
    // 'await' pauses execution until the file is fully loaded
    // .setString('fontSize', size) is a method that saves a value in local storage
    // In this case, 'fontSize' is the key under which the data is stored and size is the value you want to save
    // Basically it saves the new font size value to local storage
    // This makes sure the font size preference will be restored even after the app restarts

    notifyListeners();
    // Notifies all widgets or listeners that depend on this provider that something has changed
  }

  // -------- loadFromPrefs method --------
  // Used to load the values already saved in local storage

  Future<void> _loadFromPrefs() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (clearing the KMLs), not to return data

    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    _fontSize = prefs.getString('fontSize') ?? 'Medium';
    // prefs.getString('fontSize') tries to read the string value saved under the key 'fontSize' from SharedPreferences
    // If nothing is saved under that key (for example, it returns null), it returns 'Medium' as the default value
    // This is because of the ?? (null-aware operator)
    // The result is stored in the _fontSize variable

    _isInitialized = true;
    // The private variable _isInitialized tracks if the provider has finished loading the saved font size
    // Now is set to true because the loading process has already been finished

    notifyListeners();
    // Notifies all widgets or listeners that depend on this provider that something has changed
  }
}
