import 'package:http/http.dart' as http; // This package is necessary to send and receive data from the Internet

class LGNodeService {
  final String nodeServerUrl = 'http://localhost:3000'; // This line is the address of your local server 
                                                        // This local server is usually a Node.js server running on your computer
                                                        // This is just an example, replace with your own URL

  // We use the asynchronous mode so that the app doesn't freeze while establishing a connection
  Future<String?> getStatus() async {
    final response = await http.get(Uri.parse('$nodeServerUrl/status'));  // Sends a GET request to the server at the address of the server
                                                                          // Uri.parse(...) turns the text into a format the http package understands
                                                                          // 'await' means that the app is still running while the server answers
    // Check if everything is okay (200 is the code for 'OK')
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}
