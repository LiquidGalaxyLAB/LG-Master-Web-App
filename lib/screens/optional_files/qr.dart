// -------------------------------------------- QR CODE SCREEN --------------------------------------------
// This screen gives information about how to integrate a QR code scanner in your project

// ---------------------- Import packages ----------------------
import 'dart:convert'; // For coding and decoding JSON
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:mobile_scanner/mobile_scanner.dart'; // Used to scan QR codes and barcodes using the phone camera, must also be added on the pubspec.yaml file
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)
import 'package:url_launcher/url_launcher.dart'; // Used to open URLs in browser or apps, must also be added on the pubspec.yaml file
// For this to work on Android emulator, add permission to use the internet in the Android manifest!!
// Check the AndroidManifest.xml file for more info
// Emulators do not have a browser, try on real phone

import '../../providers/theme_provider.dart'; // Imports the file related to managing the light mode and the dark mode of the app
import '../../providers/settings_provider.dart'; // Imports the file related to managing the text sizes
import '../../services/lg_service.dart';

// ---------------------- QR screen widget ----------------------
// QRScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class QRScreen extends StatefulWidget {
  const QRScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<QRScreen> createState() => _QRScreenState();
  // This line creates the mutable state associated with QRScreen
  // The state object will hold the logic for what the QR screen does
}

// ---------------------- QR screen state ----------------------
// This class manages the state (in other words, the behavior) of the QR screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _QRScreenState extends State<QRScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  // -------- dispose --------
  // Used to
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  // -------- showError --------
  // Used to
  void _showError(String message) {
    if (!_hasError && mounted) {
      setState(() => _hasError = true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          duration: const Duration(seconds: 3),
          onVisible: () {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() => _hasError = false);
              }
            });
          },
        ),
      );
    }
  }

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Scan the QR code'),
        backgroundColor: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 167, 101, 175),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (_hasError) return;

              final barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;

              final barcode = barcodes.first;
              if (barcode.rawValue == null) return;

              try {
                final Map<String, dynamic> data = jsonDecode(barcode.rawValue!);
                final connectionModel = LgConnectionModel(
                  username: data['username'] ?? '',
                  ip: data['ip'] ?? '',
                  port: int.tryParse(data['port'].toString()) ?? 22,
                  password: data['password'] ?? '',
                  screens: int.tryParse(data['screens'].toString()) ?? 3,
                );

                if (connectionModel.username.isNotEmpty &&
                    connectionModel.ip.isNotEmpty &&
                    connectionModel.password.isNotEmpty) {
                  await controller.stop();
                  if (mounted) {
                    Navigator.pop(context, connectionModel);
                  }
                } else {
                  _showError('Invalid QR: Fields cannot be empty');
                }
              } catch (e) {
                _showError('Invalid QR: Incorrect format');
              }
            },
          ),
          Center(
            child: Container(
              width: 280,
              height: 280,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(0, _animation.value * 2 - 1),
                    child: Container(
                      height: 5,
                      width: 260,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withAlpha(0),
                            Colors.blue.withAlpha(179),
                            Colors.blue,
                            Colors.blue.withAlpha(179),
                            Colors.blue.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
