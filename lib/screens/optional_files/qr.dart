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

  String? _scannedData;
  bool _hasError = false;
  bool _hasScanned = false;

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
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _hasError = false);
        }
      });
    }
  }

  // -------- onQRCodeDetected --------
  // Used to
  void _onQRCodeDetected(String value) async {
    if (_hasScanned) return;

    setState(() {
      _scannedData = value;
      _hasScanned = true;
    });

    await controller.stop();
  }

  // -------- resetScanner --------
  // Used to
  void _resetScanner() {
    controller.start();
    setState(() {
      _hasScanned = false;
      _scannedData = null;
    });
  }

  // -------- openInBrowser --------
  // Used to
  void _openInBrowser(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError('❌ The link could not be opened');
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
      body: _hasScanned ? _buildResultView() : _buildScannerView(isDark),
    );
  }

  // -------- Scanner camera with animated line --------
  Widget _buildScannerView(bool isDark) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            final String? value = barcode.rawValue;

            if (value != null && !_hasError) {
              _onQRCodeDetected(value);
            }
          },
        ),
        Center(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? Colors.white : Colors.teal,
                width: 4,
              ),
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (_, __) {
                return Align(
                  alignment: Alignment(0, _animation.value * 2 - 1),
                  child: Container(
                    height: 4,
                    width: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.greenAccent.withAlpha(0),
                          Colors.greenAccent.withAlpha(140),
                          Colors.greenAccent,
                          Colors.greenAccent.withAlpha(140),
                          Colors.greenAccent.withAlpha(0),
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
    );
  }

  // -------- Displayed after successful scan --------
  Widget _buildResultView() {
    final isLink = _scannedData != null &&
        (_scannedData!.startsWith('http://') ||
            _scannedData!.startsWith('https://'));

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '✅ QR code scanned successfully!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SelectableText(
            _scannedData ?? 'No data.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          if (isLink)
            ElevatedButton.icon(
              onPressed: () => _openInBrowser(_scannedData!),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in browser'),
            ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _resetScanner,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan again'),
          ),
        ],
      ),
    );
  }
}
