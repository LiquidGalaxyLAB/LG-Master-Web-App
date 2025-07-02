// -------------------------------------------- MAIN SCREEN --------------------------------------------
// The first thing that should show up is the screen that contains the logos, and then this one
// This is just an example, you can customize it however you want

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'connection_screen.dart'; // Imports the screen related to the connection of the Liquid Galaxy
import 'help_screen.dart'; // Imports the screen related to help, info, or instructions about the app
import 'settings_screen.dart'; // Imports the screen related to the settings of the app
import 'optional_screen.dart'; // Imports the screen related to optional screens (Google Earth, Nodejs, AI)

// ---------------------- Main screen widget ----------------------
// MainScreen class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  // ---------------------- BuildContext widget ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
        // Top bar of the app, often used for navigation or titles

        title:
            const Text('LG Master Web App'), // Title displayed in the app bar
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // The app bar color is derived from the current app theme
      ),
      body: Container(
        // 'body' refers to the main content area of the screen

        decoration: const BoxDecoration(
          // 'decoration' is a property of the Container widget that allows to visually style the container
          // For example, setting borders, gradients, background images, etc

          gradient: LinearGradient(
            // Adds a background gradient (a smooth transition between two or more colors)
            // LinearGradient creates a linear gradient, which means the color change follows a straight line
            // You can also use RadialGradient or SweepGradient for other gradient effects
            // You can also just set the background to just one color, this is just an style choice

            colors: [Colors.deepPurple, Colors.blueAccent],
            // In this example, the gradient starts with deep purple and transitions to blue accent
            // This colors list can have as many colors as you like
            // Flutter will automatically distribute them evenly unless you specify where each color transition happens
            // You can do this with stops, for example:
            // colors: [Colors.red, Colors.yellow, Colors.green],
            // stops: [0.0, 0.5, 1.0],
            // 0.0 is the start, 0.5 is the middle, 1.0 is the end

            begin: Alignment.topLeft,
            // This line specifies where the gradient starts inside the container
            // In this case, it starts at the top-left corner

            end: Alignment.bottomRight,
            // This line specifies where the gradient ends inside the container
            // In this case, it ends at the bottom-right corner
          ),
        ),

        child: Center(
          // Centers all the widgets vertically and horizontally

          child: Column(
            // Stacks widgets vertically

            mainAxisAlignment: MainAxisAlignment.center,
            // Puts them in the center vertically

            children: [
              // ------------- Logo -------------
              Hero(
                // The Hero widget creates a shared element transition
                // This is a visual effect where a widget (in this case, a logo) seems to fly from one screen to the next

                tag: 'logo',
                // For Hero to work, both widgets must have the same tag
                // If you check the splash_screen.dart in this project, you will see the tag is the same
                // You can name the tag as you want, just make sure the name is the same in both widgets and that it is unique!
                // Both widgets must also be in different screens (Hero is meant for transitions, not in-place animations)
                // Both widgets must also have the same type and structure (for example, both being Image.asset) so Flutter can morph them correctly

                child: Image.asset(
                  // Image.asset loads an image from the project's assets folder
                  // It should be located in the 'images' folder inside the 'assets' folder
                  // It should also be added in the pubspec.yaml file, check that file to see how

                  'assets/images/LGMasterWebAppLogo.png', // Update this line with the path of your own project logo
                  width:
                      120, // Width of the image (this is just an example value of 120 px, you can use any value you want)
                  height:
                      120, // Height of the image (this is just an example value of 120 px, you can use any value you want)
                ),
              ),

              const SizedBox(height: 30),
              // Adds vertical space between the icon and the text
              // This is just an example value of 30 px, you can use any value you want
              // This is just an aesthetic choice, since it separates the logo of the projects from the other logos
              // You can add the logos the way you prefer as long as all of them are visible and easy to recognize

              // ------------- Main screen text -------------
              const Text(
                'Welcome to LG Master Web App!', // Text displayed on the screen, will be seen by the user

                style: TextStyle(
                  // Applies custom styling to the text

                  fontSize: 24,
                  // Sets the text size to 24 px
                  // As always, this is just an example value

                  fontWeight: FontWeight.bold,
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)

                  color: Colors.white,
                  // Sets the text color to white

                  letterSpacing: 1.2,
                  // Adds space between each character (1.2 pixels in this case)
                  // As always, this is just an example value
                ),
                textAlign: TextAlign.center,
                // Aligns the text horizontally to the center of its container
              ),

              const SizedBox(height: 40),
              // Adds vertical space between the icon and the text
              // This is just an example value of 40 px, you can use any value you want
              // This is just an aesthetic choice, since it separates the logo of the projects from the other logos
              // You can add the logos the way you prefer as long as all of them are visible and easy to recognize

              // ------------- Navigation buttons -------------
              // Each button is a custom widget (_HomeButton)

              // CONNECTION SCREEN BUTTON
              _HomeButton(
                // _HomeButton is a custom widget we created at the end of this file
                // It is reusable

                label: 'Connection',
                // 'label' is a parameter passed to _HomeButton which sets the text shown on the button

                icon: Icons.link,
                // 'icon' specifies the icon that will be displayed on the button
                // Icons.link is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a chain link

                color: Colors.orange,
                // 'color' sets the background color of the button
                // In this case, it is orange

                onTap: () {
                  // 'onTap' defines what happens when the user taps the button

                  Navigator.push(
                    // In this case, it navigates to the connection screen when tapped
                    // Navigator.push adds a new screen (it transitions to a new page)

                    context,
                    MaterialPageRoute(builder: (_) => const ConnectionScreen()),
                    // MaterialPageRoute is used to create a page transition animation
                    // ConnectionScreen is the class associated to the connection screen
                  );
                },
              ),

              // HELP SCREEN BUTTON
              _HomeButton(
                // _HomeButton is a custom widget we created at the end of this file
                // It is reusable

                label: 'Help',
                // 'label' is a parameter passed to _HomeButton which sets the text shown on the button

                icon: Icons.help_outline,
                // 'icon' specifies the icon that will be displayed on the button
                // Icons.help_outline is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a question mark

                color: Colors.green,
                // 'color' sets the background color of the button
                // In this case, it is green

                onTap: () {
                  // 'onTap' defines what happens when the user taps the button

                  Navigator.push(
                    // In this case, it navigates to the help screen when tapped
                    // Navigator.push adds a new screen (it transitions to a new page)

                    context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()),
                    // MaterialPageRoute is used to create a page transition animation
                    // HelpScreen is the class associated to the help screen
                  );
                },
              ),

              // SETTINGS SCREEN BUTTON
              _HomeButton(
                // _HomeButton is a custom widget we created at the end of this file
                // It is reusable

                label: 'Settings',
                // 'label' is a parameter passed to _HomeButton which sets the text shown on the button

                icon: Icons.settings,
                // 'icon' specifies the icon that will be displayed on the button
                // Icons.settings is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a gear

                color: Colors.cyan,
                // 'color' sets the background color of the button
                // In this case, it is cyan

                onTap: () {
                  // 'onTap' defines what happens when the user taps the button

                  Navigator.push(
                    // In this case, it navigates to the settings screen when tapped
                    // Navigator.push adds a new screen (it transitions to a new page)

                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    // MaterialPageRoute is used to create a page transition animation
                    // SettingsScreen is the class associated to the settings screen
                  );
                },
              ),

              // OPTIONAL SCREENS BUTTON
              _HomeButton(
                // _HomeButton is a custom widget we created at the end of this file
                // It is reusable

                label: 'Optional Screens',
                // 'label' is a parameter passed to _HomeButton which sets the text shown on the button

                icon: Icons.explore,
                // 'icon' specifies the icon that will be displayed on the button
                // Icons.explore is a built-in Flutter icon (an icon that already exists in Flutter) that looks like a compass

                color: Colors.purple,
                // 'color' sets the background color of the button
                // In this case, it is purple

                onTap: () {
                  // 'onTap' defines what happens when the user taps the button

                  Navigator.push(
                    // In this case, it navigates to the screen that has info on Google Earth, AI and Nodejs when tapped
                    // Navigator.push adds a new screen (it transitions to a new page)

                    context,
                    MaterialPageRoute(builder: (_) => const OptionalScreen()),
                    // MaterialPageRoute is used to create a page transition animation
                    // OptionalScreen is the class associated to the screen related to optional features (Google Earth, AI and Nodejs)
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------- Reusable Button Widget ----------------------
// _HomeButton is a custom stateless widget that defines the appearance and behavior of each button on the home screen
// This is a reusable widget that we created to make the code more efficient

class _HomeButton extends StatelessWidget {
  // It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
  // This means the content will not change after it is built
  // The underscore (_) makes the class PRIVATE to the file it is defined in
  // This is useful when the widget is only used in one file, but it is not mandatory to make it private

  final String label;
  // Variable called 'label' used to define the text that will appear on the button

  final IconData icon;
  // Variable called 'icon' used to hold the icon shown next to the text

  final Color color;
  // Variable called 'color' used to define the background color of the botton

  final VoidCallback onTap;
  // Declares a VoidCallback (a function that returns nothing) to define what should happen when the button is tapped
  // We use a function that returns nothing because when we are just triggering an action (navigating to another screen, showing a dialog,
  // printing something to the console, etc) these actions DO NOT return any value and ONLY need to be executed when the button is tapped

  const _HomeButton({
    // Constructor fo the widget, allows to pass values to the label, icon, color and onTap parameters
    // 'required' makes sure the values MUST be provided in order to use _HomeButton
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
    // Passes an optional widget key to the superclass (SatatelessWidget), which Flutter uses for widget identification and efficient rebuilds
  });

  @override
  // Tells Dart that we are overriding the build method of Stateless widget

  Widget build(BuildContext context) {
    return Padding(
      // Padding is used to add space around the button

      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // In this case, it adds 8 px of vertical space (top and bottom) around the bottom
      // As always, you can customize these values to your liking
      // If you wanted to add padding on top, bottom, left and right you would use EdgeInsets.all(8.0);
      // If you wanted to add padding on left and right you would use EdgeInsetssymmetric(horizontal: 8.0);
      // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      // You can add padding on individual sides, for example:
      // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
      // EdgeInsets.only(left: 8.0, top: 10.0)

      child: ElevatedButton.icon(
        // Creates a button with both icon and text

        style: ElevatedButton.styleFrom(
          // Customizes the appeareance of the button

          backgroundColor: color,
          // Sets button background color to the color passed to the widget

          foregroundColor: Colors.white,
          // Sets icon and text color to white in this case

          minimumSize: const Size(200, 48),
          // Button size, in this case it forces it to be at least 200 px wide and 48 px tall

          shape: RoundedRectangleBorder(
            // Give the button rounder corners
            borderRadius: BorderRadius.circular(30),
            // In this case, it uses a radius of 30 px
          ),
          elevation: 5,
          // Adds a shadow to make the button look raised
          // It has to be a double
          // 0 is no shadow, you can set any positive number but above 24 it usually doe snot have much visual effect
          // Higher numbers mean a bigger, softer shadow, making the button look more lifted above the surface
          // Lower numbers mean a smaller, sharper shadow, making the button appear closer to the background
        ),

        icon: Icon(icon, size: 28),
        // Displays the icon specified in the icon parameter with (in this case) a size of 28 px

        label: Text(
          // Displays the text with specific styling
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          // You can adjust these values with your liking
          // In this case, it sets the text size to 28 px and makes it semi-bold or medium (w500)
        ),

        onPressed: onTap,
        // Assigns the function that should run when the button is pressed, which is passed to the widget as 'onTap'
      ),
    );
  }
}
