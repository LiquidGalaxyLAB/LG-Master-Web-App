// -------------------------------------------- LG SERVICE --------------------------------------------
// File dedicated to manage everything that has to do with the connection to the Liquid Galaxy

// ---------------------- Import packages ----------------------
import 'dart:async'; // Imports the Dart asynchronous tools
import 'dart:io'; // Used for handling socket exceptions and network errors
import 'package:flutter/foundation.dart'; // Imports the foundation librray used to manage ChangeNotification
import 'package:dartssh2/dartssh2.dart'; // SSH package used to connect to and send commands to the Liquid Galaxy
// IMPORTANT!! Add this also in pubspec.yaml

import 'package:shared_preferences/shared_preferences.dart'; // Imports shared_preferences to storing small amounts of persistent data
// For example, app settings

// ---------------------- LG model ----------------------
// Model used for storing Liquid Galaxy connection parameters
class LgConnectionModel {
  String username;
  // The "username" variable is used to store the username for SSH login

  String ip;
  // The "ip" variable is used to store the IP address of the Liquid Galaxy host

  int port;
  // The "port" variable is used to store the port number of the SSH connection

  String password;
  // The "password" variable is used to store the password for SSH authentication

  int screens;
  // The "screens" variable is used to store the number of screens in the Liquid Galaxy rig

  // ---- Keys used to store values from shared preferences ----
  static const String _keyUsername = 'lg_username';
  // The _keyUsername key will be used to store and retrieve the username from SharedPreferences
  // It is initialized to the default vale 'lg_username'

  static const String _keyIp = 'lg_ip';
  // The _keyIp key will be used to store and retrieve the ip from SharedPreferences
  // It is initialized to the default vale 'lg_ip'

  static const String _keyPort = 'lg_port';
  // The _keyPort key will be used to store and retrieve the port number from SharedPreferences
  // It is initialized to the default vale 'lg_port'

  static const String _keyPassword = 'lg_password';
  // The _keyPassword key will be used to store and retrieve the password from SharedPreferences
  // It is initialized to the default vale 'lg_password'

  static const String _keyScreens = 'lg_screens';
  // The _keyScreens key will be used to store and retrieve the number of screens from SharedPreferences
  // It is initialized to the default vale 'lg_screens'

  LgConnectionModel({
    this.username = 'lg',
    // Default username

    this.ip = '',
    // Default IP address

    this.port = 22,
    // Default port number

    this.password = 'lqgalaxy',
    // Default password

    this.screens = 5,
    // Default number of screens
  });

  // -------- updateConnection --------
  // Updates the values of the connection with the new parameters provided if they are not null
  void updateConnection({
    String? username,
    // Defines parameter called "username" of type String?
    // The ? means this parameter is nullable
    // This means that, if not provided, its value will be "null"

    String? ip,
    // Defines parameter called "ip" of type String?
    // The ? means this parameter is nullable
    // This means that, if not provided, its value will be "null"

    int? port,
    // Defines parameter called "port" of type int?
    // The ? means this parameter is nullable
    // This means that, if not provided, its value will be "null"

    String? password,
    // Defines parameter called "password" of type String?
    // The ? means this parameter is nullable
    // This means that, if not provided, its value will be "null"

    int? screens,
    // Defines parameter called "screens" of type int?
    // The ? means this parameter is nullable
    // This means that, if not provided, its value will be "null"
  }) {
    this.username = username ?? this.username;
    // If a new username is provided ("username"), updates the username field with this vale
    // If not, the fallback value (the value after ??) is used, which in this case is the old value (this.username)

    this.ip = ip ?? this.ip;
    // If a new ip is provided ("ip"), updates the ip field with this vale
    // If not, the fallback value (the value after ??) is used, which in this case is the old value (this.ip)

    this.port = port ?? this.port;
    // If a new port number is provided ("port"), updates the port field with this vale
    // If not, the fallback value (the value after ??) is used, which in this case is the old value (this.port)

    this.password = password ?? this.password;
    // If a new password is provided ("password"), updates the password field with this vale
    // If not, the fallback value (the value after ??) is used, which in this case is the old value (this.password)

    this.screens = screens ?? this.screens;
    // If a new number of screens is provided ("screens"), updates the screens field with this vale
    // If not, the fallback value (the value after ??) is used, which in this case is the old value (this.screens)
  }

  // -------- saveToPreferences --------
  // Saves the current connection values to the preferences stored in the local storage

  Future<void> saveToPreferences() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect, not to return data

    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    await prefs.setString(_keyUsername, username);
    // Saves the "username" value in local storage under the "_keyUsername" key

    await prefs.setString(_keyIp, ip);
    // Saves the "ip" value in local storage under the "_keyIp" key

    await prefs.setInt(_keyPort, port);
    // Saves the "port" value in local storage under the "_keyPort" key

    await prefs.setString(_keyPassword, password);
    // Saves the "password" value in local storage under the "_keyPassword" key

    await prefs.setInt(_keyScreens, screens);
    // Saves the "screens" value in local storage under the "_keyScreens" key
  }

  // -------- loadFromPreferences --------
  // Loads connection values from shared preferences and returns a new model instance
  static Future<LgConnectionModel> loadFromPreferences() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function

    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences.getInstance() is used to get access to local storage
    // 'await' pauses execution until the file is fully loaded
    // The reference to the preferences storage is saved in the "prefs" variable

    return LgConnectionModel(
      // New model instance

      username: prefs.getString(_keyUsername) ?? 'lg',
      // Loads the username from local storage (prefs.getString(_keyUsername))
      // If there is no username in local storage, the fallback value (the value after ??) is used
      // Which in this case is the default value established earlier ('lg')

      ip: prefs.getString(_keyIp) ?? '',
      // Loads the ip from local storage (prefs.getString(_keyIp))
      // If there is no ip in local storage, the fallback value (the value after ??) is used
      // Which in this case is the default value established earlier ('')

      port: prefs.getInt(_keyPort) ?? 22,
      // Loads the port from local storage (prefs.getString(_keyPort))
      // If there is no port in local storage, the fallback value (the value after ??) is used
      // Which in this case is the default value established earlier (22)

      password: prefs.getString(_keyPassword) ?? 'lqgalaxy',
      // Loads the password from local storage (prefs.getString(_keyPassword))
      // If there is no password in local storage, the fallback value (the value after ??) is used
      // Which in this case is the default value established earlier ('lqgalaxy')

      screens: prefs.getInt(_keyScreens) ?? 5,
      // Loads the screens number from local storage (prefs.getString(_keyScreens))
      // If there is no screens number in local storage, the fallback value (the value after ??) is used
      // Which in this case is the default value established earlier (5)
    );
  }
}

// ---------------------- LgService class ----------------------
// Service to establish and manage the connection to LG
class LgService extends ChangeNotifier {
  // The class LgService extends ChangeNotifierProvider because it allows widgets to listen for changes
  // Makes sure there is only one instance of LgService across the whole app (which is called singleton pattern)
  // Useful to manage a SINGLE connection or state across different parts of the app

  LgService._internal();
  // Private constructor (_), only accessible from within the class
  // Prevents creating multiple instances from outside the class

  static final LgService _singleton = LgService._internal();
  // This line creates and stores the single instance of the LgService class under the name "_singleton"
  // 'static' means it belongs to the class itself, NOT to an object
  // 'final' means it cannot be reassigned after being initialized

  factory LgService() => _singleton;
  // Instead of creating a new object, it returns the existing _instance that was created earlier
  // This enforces the Singleton behavior by always returning the same object

  final LgConnectionModel _lgConnectionModel = LgConnectionModel();
  // Creates a private instance of LgConnectionModel (which holds LG connection settings) under the name "_lgConnectionModel"
  // 'final' means it cannot be reassigned after being initialized

  // -------- SSH client and connection details --------
  SSHClient? _client;
  // The private variable _client will store the active SSH connection
  // ? means it can be null if there is no current connection

  Timer? _orbitTimer;
  Timer? _connectionTimer;

  bool _isTrailPlaying = false;
  bool _orbitPlaying = false;
  bool _isConnected = false;
  bool _isCheckingConnection = false;
  int _currentConnectionAttempts = 0;

  static const int _maxConnectionAttempts = 5;
  static const Duration _connectionTimeout = Duration(seconds: 10);

  LgConnectionModel get connectionModel => _lgConnectionModel;

  // -------- updateConnectionSettings --------
  // Used to
  void updateConnectionSettings({
    required String ip,
    required int port,
    required String username,
    required String password,
    required int screens,
  }) {
    _lgConnectionModel.updateConnection(
      ip: ip,
      port: port,
      username: username,
      password: password,
      screens: screens,
    );
  }

  // -------- initializeConnection --------
  // Used to
  Future<void> initializeConnection() async {
    try {
      final savedModel = await LgConnectionModel.loadFromPreferences();
      updateConnectionSettings(
        ip: savedModel.ip,
        port: savedModel.port,
        username: savedModel.username,
        password: savedModel.password,
        screens: savedModel.screens,
      );
      await connectToLG();
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  // -------- connectToLG --------
  // Used to
  Future<bool?> connectToLG() async {
    if (_currentConnectionAttempts >= _maxConnectionAttempts) {
      _currentConnectionAttempts = 0;
      return false;
    }

    try {
      final socket = await SSHSocket.connect(
        _lgConnectionModel.ip,
        _lgConnectionModel.port,
      ).timeout(_connectionTimeout);

      _client = SSHClient(
        socket,
        username: _lgConnectionModel.username,
        onPasswordRequest: () => _lgConnectionModel.password,
        keepAliveInterval: const Duration(seconds: 10),
      );

      _isConnected = true;
      _currentConnectionAttempts = 0;
      notifyListeners();
      return true;
    } on TimeoutException {
      _currentConnectionAttempts++;
    } on SocketException {
      _currentConnectionAttempts++;
    }

    return false;
  }

  // -------- disconnect --------
  // Used to
  void disconnect() {
    _client?.close();
    _client = null;
    _isConnected = false;
  }

  // -------- execute --------
  // Used to
  Future<dynamic> execute(String command, String successMessage) async {
    if (_client == null) {
      debugPrint('SSH client NOT connected');
      return null;
    }

    try {
      final result = await _client!.execute(command);
      debugPrint(successMessage);
      return result;
    } catch (e) {
      debugPrint('There was an error executing the command: $e');
      return null;
    }
  }

  // -------- query --------
  // Used to
  Future<bool> query(String content) async {
    final result = await execute(
      'echo "$content" > /tmp/query.txt',
      'Query sent: $content',
    );
    return result != null;
  }

  // -------- calculateRightMostScreen --------
  // Used to
  int calculateRightMostScreen(int screenCount) {
    return screenCount == 1 ? 1 : (screenCount / 2).floor() + 1;
  }

  // -------- calculateLeftMostScreen --------
  // Used to
  int calculateLeftMostScreen(int screenCount) {
    return screenCount == 1 ? 1 : (screenCount / 2).floor() + 2;
  }

  // -------- _forceRefresh --------
  // Used to
  Future<void> _forceRefresh(int screenNumber) async {
    try {
      final search =
          '<href>##LG_PHPIFACE##kml\\/slave_$screenNumber.kml<\\/href>';
      final replace =
          '<href>##LG_PHPIFACE##kml\\/slave_$screenNumber.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>1<\\/refreshInterval>';

      final addCommand =
          'echo ${_lgConnectionModel.password} | sudo -S sed -i "s|$search|$replace|" ~/earth/kml/slave/myplaces.kml';

      await execute(
        "sshpass -p ${_lgConnectionModel.password} ssh -t lg$screenNumber '$addCommand'",
        'Refresh interval added to screen $screenNumber',
      );

      await Future.delayed(const Duration(seconds: 1));

      final searchWithRefresh =
          '<href>##LG_PHPIFACE##kml\\/slave_$screenNumber.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>[0-9]+<\\/refreshInterval>';
      final restore =
          '<href>##LG_PHPIFACE##kml\\/slave_$screenNumber.kml<\\/href>';

      final removeCommand =
          'echo ${_lgConnectionModel.password} | sudo -S sed -i "s|$searchWithRefresh|$restore|" ~/earth/kml/slave/myplaces.kml';

      await execute(
        "sshpass -p ${_lgConnectionModel.password} ssh -t lg$screenNumber '$removeCommand'",
        'Refresh interval removed from screen $screenNumber',
      );
    } catch (e) {
      debugPrint('Error in _forceRefresh: $e');
    }
  }

  // -------- flyTo --------
  // Used to
  Future<void> flyTo(String kmlViewTag) async {
    await query('flytoview=$kmlViewTag');
  }

  // -------- handleDisconnection --------
  // Used to
  void _handleDisconnection() {
    _isConnected = false;
    _client?.close();
    _client = null;
    _isTrailPlaying = false;
    _orbitPlaying = false;
    _orbitTimer?.cancel();
    notifyListeners();

    if (_currentConnectionAttempts < _maxConnectionAttempts) {
      Future.delayed(const Duration(seconds: 3), () {
        connectToLG();
      });
    }
  }

  // -------- startConnectionCheck --------
  // Used to
  void _startConnectionCheck() {
    _connectionTimer?.cancel();
    _connectionTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_isCheckingConnection) {
        _checkConnection();
      }
    });
  }

  // -------- checkConnection --------
  // Used to
  Future<void> _checkConnection() async {
    if (_client == null || _isCheckingConnection) return;
    _isCheckingConnection = true;

    try {
      await _client!.execute('echo "ping"').timeout(const Duration(seconds: 3));
      _isConnected = true;
    } catch (e) {
      _handleDisconnection();
    } finally {
      _isCheckingConnection = false;
      notifyListeners();
    }
  }

  // -------- cleanKML --------
  // Used to
  Future<bool> cleanKML() async {
    bool allSuccessful = true;

    final clearCommand =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
    final headerCleared = await execute(
      clearCommand,
      'KMLs.txt cleared',
    );
    allSuccessful = allSuccessful && (headerCleared != null);

    int rightMost = calculateRightMostScreen(_lgConnectionModel.screens);
    const blankKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document><name>Empty</name></Document>
</kml>''';

    final cleared = await execute(
      "echo '$blankKml' > /var/www/html/kml/slave_$rightMost.kml",
      'Rightmost screen cleared',
    );
    allSuccessful = allSuccessful && (cleared != null);

    await _forceRefresh(rightMost);

    return allSuccessful;
  }

  // -------- cleanLogos --------
  // Used to
  Future<void> cleanLogos() async {
    int leftMost = calculateLeftMostScreen(_lgConnectionModel.screens);
    const blankKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document><name>Logo</name></Document>
</kml>''';

    await execute(
      "echo '$blankKml' > /var/www/html/kml/slave_$leftMost.kml",
      'Logo KML cleared',
    );
    await _forceRefresh(leftMost);
  }

  // -------- cleanBalloonKML --------
  // Used to
  Future<void> cleanBalloonKML() async {
    int rightMost = calculateRightMostScreen(_lgConnectionModel.screens);
    const blankKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document><name>Balloon</name></Document>
</kml>''';

    await execute(
      "echo '$blankKml' > /var/www/html/kml/slave_$rightMost.kml",
      'Balloon KML cleared',
    );
    await _forceRefresh(rightMost);
  }

  // -------- cleanAll --------
  // Used to
  Future<void> cleanAll() async {
    try {
      _orbitTimer?.cancel();
      _connectionTimer?.cancel();

      if (_isTrailPlaying) await trailStop();
      if (_orbitPlaying) await orbitStop();

      await Future.wait([
        cleanKML(),
        cleanLogos(),
        cleanBalloonKML(),
      ]);

      _isTrailPlaying = false;
      _orbitPlaying = false;

      final screens = List.generate(_lgConnectionModel.screens, (i) => i + 1);
      await Future.wait(screens.map(_forceRefresh));

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error during cleanAll: $e');
      _isTrailPlaying = false;
      _orbitPlaying = false;
      notifyListeners();
    }
  }

  // -------- trailStop --------
  // Used to
  Future<void> trailStop() async {
    _orbitTimer?.cancel();
    _isTrailPlaying = false;
    notifyListeners();
    await _forceRefresh(1);
  }

  // -------- orbitStop --------
  // Used to
  Future<void> orbitStop() async {
    _orbitTimer?.cancel();
    _orbitPlaying = false;
    notifyListeners();
    await query('exittour=true');
  }

  // -------- reboot --------
  // Used to
  Future<bool> reboot() async {
    try {
      await connectToLG();
      bool allSuccessful = true;

      await cleanAll();
      await Future.delayed(const Duration(seconds: 2));

      for (int i = _lgConnectionModel.screens; i >= 1; i--) {
        final rebootCommand =
            'sshpass -p ${_lgConnectionModel.password} ssh -t lg$i '
            '"echo ${_lgConnectionModel.password} | sudo -S reboot"';

        final result = await execute(
          rebootCommand,
          'Screen $i was successfully rebooted',
        );

        allSuccessful = allSuccessful && (result != null);
      }

      _isConnected = false;
      _client?.close();
      _client = null;
      notifyListeners();

      Future.delayed(const Duration(seconds: 50), () async {
        _startConnectionCheck();
        for (int i = 0; i < 10; i++) {
          if (await connectToLG() == true) {
            debugPrint('Successfully reconnected to the LG');
            await flyTo(
                '<LookAt><longitude>-3.7492199</longitude><latitude>40.4636688</latitude><altitude>0</altitude><heading>0</heading><tilt>60</tilt><range>1500000</range><altitudeMode>relativeToGround</altitudeMode></LookAt>');
            break;
          }
          await Future.delayed(const Duration(seconds: 5));
        }
      });

      return allSuccessful;
    } catch (e) {
      debugPrint('There was an error during reboot: $e');
      _handleDisconnection();
      return false;
    }
  }
}
