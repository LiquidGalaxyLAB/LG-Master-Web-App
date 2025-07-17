// -------------------------------------------- SETTINGS SCREEN --------------------------------------------
// Screen dedicated to manage visual preferences like dark mode or font size

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)
import '../providers/settings_provider.dart'; // Imports the file we created to manage font sizes
import '../providers/theme_provider.dart'; // Imports the file we created to manage dark and light mode

// ---------------------- Settings screen widget ----------------------
// SettingsScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the build() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    // Access the current instance of SettingsProvider (a class from settings_provider.dart)
    // This class has information on the different font sizes for the text
    // Stores this instance in a variable called "settingsProvider"
    // final means this variable can only be assigned ONCE and will not change

    final themeProvider = Provider.of<ThemeProvider>(context);
    // Access the current instance of ThemeProvider (a class from theme_provider.dart)
    // This class has information on dark and light mode
    // Stores this instance in a variable called "themeProvider"
    // final means this variable can only be assigned ONCE and will not change

    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title: const Text('App settings'),
        // Title displayed in the app bar

        backgroundColor: Theme.of(context).colorScheme.primary,
        // The app bar color is derived from the current app theme
        // Theme.of(context).colorScheme.primary makes sure the color matches the overall app color scheme
        // This also automatically adjusts for dark or light mode
      ),
      body: ListView(
        // 'body' refers to the main content area of the screen
        // ListView is a widget that displays its children linearly
        // It is vertically by default but can also be horizontally
        // In this case, it is used to display the different optional features

        padding: const EdgeInsets.all(16),
        // Adds padding of 16 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        children: [
          // List of child widgets that will be stacked vertically

          // ------- ICON AND TITLE -------
          const Icon(Icons.settings,
              // Icons.settings is a built-in Flutter icon (an icon that already exists in Flutter) that looks like an engine
              // You can choose other icons

              size: 70,
              // Sets the icon size to 70 px
              // You can choose the size you want

              color: Colors.cyan
              // Sets the icon color to cyan
              // You can choose other colors
              ),

          const SizedBox(height: 16),
          // Adds vertical space between the title and the explanation
          // This is just an example value of 16 px, you can use any value you want
          // This is just an aesthetic choice

          const Text(
            'Customize your app experience!',
            // Text that appears on the screen

            textAlign: TextAlign.center,
            // Aligns the text horizontally to the center of its container

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
          ),
          const Divider(height: 32),
          // Places a horizontal line ("divider") to visually separate sections
          // This is just an example value of 32 px, you can use any value you want
          // This is just an aesthetic choice
          // It visually displays a line, it is not just space like SizedBox

          // ------- DARK MODE OPTION -------
          SwitchListTile(
            // SwitchListTile is widget that combines a switch (toggle) with a list tile
            // Usually to present settings or preferences that can be turned on and off

            title: const Text('Dark mode'),
            // Title of the list item

            secondary: const Icon(Icons.dark_mode),
            // Icon of the list item
            // Icons.dark_mode shows a moon, but you can choose any icon you want
            // "secondary" means this widget is optional
            // The secondary parameter places widgets on the left

            value: themeProvider.isDarkMode,
            // "value" is used to track the current state of the switch
            // In this case, true means dark mode is enabled and false means light mode is enabled
            // The switch appearance reflects this value

            onChanged: themeProvider.toggleTheme,
            // The value of "onChanged" is what happens when the switch is toggled (tapped on)
            // When the switch is tapped, SwitchListTile automatically calls the function provided to onChanged
            // In this case, it is themeProvider.toggleTheme, a method from theme_provider.dart that changes the app theme
          ),

          const SizedBox(height: 16),
          // Adds vertical space
          // This is just an example value of 16 px, you can use any value you want
          // This is just an aesthetic choice

          // ------- FONT SIZE OPTIONS-------
          ListTile(
            // A ListTile widget defines a single row

            leading: const Icon(Icons.text_fields),
            // "leading" adds an icon at the start (left) of the row
            // Icons.text_fields is a built-in Flutter icon representing two T letters
            // You can choose any icon you want

            title: const Text('Font size'),
            // Main label for this row

            trailing: DropdownButton<String>(
              // "trailing" adds a widget at the end (right side) of the row
              // DropdownButton is a menu that lets the user pick from a set of options
              // <String> states that the dropdown values are strings

              value: settingsProvider.fontSize,
              // Sets the value of the "value" variable to the current selected option shown in the dropdown
              // settingsProvider.fontSize holds the currently chosen font size as a string ('Small', 'Medium', or 'Large').

              onChanged: (value) {
                // The value of "onChanged" is what happens when the switch is toggled (tapped on)

                if (value != null) {
                  // If the selected option from the dropdown (stored in "value") is NOT null, this block runs

                  settingsProvider.setFontSize(value);
                  // Passes the new font size value the user picked calling the setFontSize() method from settingsProvider class
                  // This updates the global app setting for font size, resizing the entire app

                  ScaffoldMessenger.of(context).showSnackBar(
                    // Scaffold is a basic page layout that creates an structure for the screen
                    // Shows a temporary message (a SnackBar) at the bottom of the screen

                    SnackBar(
                      content: Text('Font size set to $value'),
                      // In this case, it is a message to inform the value of the font size that is currently being used
                    ),
                  );
                }
              },
              items: const [
                // List of items that will be shown as options in the dropdown menu

                DropdownMenuItem(value: 'Small', child: Text('Small')),
                // Single option from the dropdown menu
                // value: 'Small' means 'Small' is the returned value when this menu item is selected
                // child: Text('Small') is the widget that is displayed to the user as the menu item (in this case it is the "Small" option)

                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                // Single option from the dropdown menu
                // value: 'Medium' means 'Medium' is the returned value when this menu item is selected
                // child: Text('Medium') is the widget that is displayed to the user as the menu item (in this case it is the "Medium" option)

                DropdownMenuItem(value: 'Large', child: Text('Large')),
                // Single option from the dropdown menu
                // value: 'Large' means 'Large' is the returned value when this menu item is selected
                // child: Text('Large') is the widget that is displayed to the user as the menu item (in this case it is the "Large" option)
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Adds vertical space between the title and the explanation
          // This is just an example value of 24 px, you can use any value you want
          // This is just an aesthetic choice

          // ------- GOING BACK BUTTON -------
          ElevatedButton.icon(
            // Creates a button with both icon and text

            onPressed: () => Navigator.pop(context),
            // Assigns the function that should run when the button is pressed
            // In this case, Navigator.pop(context) closes the current screen and go back to the previous one

            icon: const Icon(Icons.arrow_back),
            // 'icon' specifies the icon that will be displayed on the button
            // Icons.arrow_back is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a arrow pointing to the left

            label: const Text('Back'),
            // Text shown on the button

            style: ElevatedButton.styleFrom(
              // Customizes the appeareance of the button

              backgroundColor: Theme.of(context).colorScheme.primary,
              // Sets button background color to the primary color currently defined in the app theme
              // You can choose a different color if you want

              foregroundColor: Colors.white,
              // Sets icon and text color to white in this case
              // You can choose a different color if you want
            ),
          ),
        ],
      ),
    );
  }
}
