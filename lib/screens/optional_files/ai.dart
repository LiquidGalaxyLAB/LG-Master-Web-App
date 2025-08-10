// -------------------------------------------- AI SCREEN --------------------------------------------
// This screen gives information about how to integrate AI on your project to generate responses based on prompts
// It sends a POST request to the Gemini API and displays the AI response on the screen

// ------------------------------------- HOW TO GET A GEMINI API KEY -------------------------------------
// FOR GEMINI:
// Sign in to your Google account
// Go to Google AI Studio
// Look for the 'Gemini API' tab or a button that says 'Get API key in Google AI Studio'
// Click 'Get API Key' or 'Create API Key'
// Review and accept the terms of service
// Copy your API key. DO NOT SHARE IT OR COPY IT INTO PUBLIC CODE REPOSITORIES!!!
// Copy your API key into the .env file, specifiy in .gitgnore to ignore this file so it will not be uploaded to GitHub

// ---------------------- Import packages ----------------------
import 'dart:convert'; // For coding and decoding JSON
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:http/http.dart'
    as http; // HTTP client to send requests to the Gemini API
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Used to load and access environment variables from a .env file

// ---------------------- API configuration parameters ----------------------
// ---- Gemini endpoint with given model and API key ----
final String geminiApiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${dotenv.env['GEMINI_API_KEY']}';

// This is the Gemini endpoint
// An endpoint is a way to a specific resource or function on a server
// https://generativelanguage.googleapis.com/ is the base URL
// v1beta/models/gemini-2.0-flash:generateContent specifies the gemini model (gemini-2.0-flash in this case) and calls its generateContent method
// This model works for my API key, but always check which models work for YOUR API key
// ?key=${dotenv.env['GEMINI_API_KEY']} appends the API key as a query parameter for authentication and authorization
// dotenv.env['GEMINI_API_KEY'] returns the value of GEMINI_API_KEY from the file
// The API key is EXTREMELY sensitive information
// It should be in an .env file that should be specified to be ignored in .gitignore
// The .env file MUST be specified in the pubspec assets section!
// The .env file MUST also be outside the "lib" folder, on the same level as pubspec.yaml

// ---------------------- AI Screen widget ----------------------
// AIScreen class is the root widget of the screen, and all other widgets are built from there
// This means that all the other parts of the screen (buttons, text, etc) will be built from this starting point
// It extends StatefulWidget because its state changes after a few seconds
// If it did NOT change, we would use StatelessWidget
class AIScreen extends StatefulWidget {
  const AIScreen({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the initState() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  State<AIScreen> createState() => _AIScreenState();
  // This line creates the mutable state associated with AIScreen
  // The state object will hold the logic for what the AI screen does
}

// ---------------------- AI screen state ----------------------
// This class manages the state (in other words, the behavior) of the AI screen
// The state of a widget is basically the changing data
// In Flutter a State class is where the data that can be changed while the app is running is stored and managed
// When the state changes, the widget rebuilds itself to show the new data
class _AIScreenState extends State<AIScreen> {
  final TextEditingController _controller = TextEditingController();
  // Creates a controller to manage and retrieve the text entered in the input field
  // It allows to get the current value of the input, clear the input and listen for changes if needed

  String _response = '';
  // Stores the Gemini AI response
  // Initialized as an empty string because nothings has been received yet
  // Will be updated after the user sends a message and the AI returns an answer

  bool _loading = false;
  // Tracks if the app is waiting for a response from Gemini
  // true means a request is in progress
  // false means a request is not in progress, which means introducing an input is allowed
  // That is ahy false is the default value

  // ---- Send prompt to Gemini ----
  Future<void> _sendPrompt() async {
    // Defines an asynchronous method that does not return any value (void)
    // 'async' allows to use 'await' inside the function
    // It does not return any value because its function is to trigger a side-effect (connecting to a service), not to return data

    final prompt = _controller.text.trim();
    // Gets the user input the _controller
    // _controller is an object that controls a text field in Flutter and lets you read, change, and clear the text
    // .trim() removes any leading and trailing whitespace (spaces, tabs, newlines) from the input
    // This makes sure the API is not called with just spaces or empty lines
    // This process is called trimming
    // The result is stored in the variable called 'prompt'

    if (prompt.isEmpty) return;
    // Checks if the user’s input is empty after trimming
    // If it is, the function exits and no request is sent
    // This prevents sending invalid or empty prompts to the Gemini API

    setState(() {
      // setState() is used to rebuild the UI when the state changes

      _loading = true;
      // If _loading = true, this means a request is in progress

      _response = '';
      // Clears previous responses from the screen
    });

    try {
      // Build the request body in the format required by the Gemini API
      // Keep in mind this is the structure for Gemini API, other models may have other structures

      final body = jsonEncode({
        // Declares a variable named 'body'
        // This variable will hold the final JSON string that will be sent in the POST request to the Gemini API
        // jsonEncode converts into a JSON string, which is the format required when sending data to APIs
        // The following structure corresponds to the JSON structure of the Gemini model I am using
        // But be careful!!! Different models may have different structures

        "contents": [
          // Starts a key named "contents" whose value is an array in JSON (a list)
          // Structure expected for the gemini-2.0-flash model to specify contents

          {
            "parts": [
              // Object inside the "contents" array
              // The "parts" key maps to another array
              // In this case, it is used to indicate different parts or segments of the content being sent

              {"text": prompt}
              // Object inside the "parts" array with a key called "text"
              // The value of this key-value pair is "prompt", which holds the user input
              // It means that the prompt from the user (a string) is being sent as the text inside the prompt
            ]
          }
        ],
        // Careful with parameters like "temperature" and "maxOutputTokens"!!!!
        // Depending on the model, they might not be allowed and your code will not work if you use them
        // Anyway, just so you have some info:

        // "temperature" controls how random the AI answers are
        // 0.0 means predictable and safe
        // 1.0 means creative and random

        // "maxOutputTokens" is the maximum number of tokens (words or parts of words) the response can contain
        // This helps control the length of the answer
      });

      // ---- Send HTTP POST request to Gemini endpoint ----
      final response = await http.post(
        // Sends an HTTP POST request asynchronously
        // http.post is used to make a POST request
        // 'response' stores the result of the HTTP call

        Uri.parse(geminiApiUrl),
        // Sets the URL for the request
        // 'geminiApiUrl' is a string containing the URL to which the POST request is sent
        // Uri.parse(...) converts the string into a Uri object (into a URL), which is required by http.post

        headers: {'Content-Type': 'application/json'},
        // Sets request headers, which are key-value pairs that provide metadata about the request or response
        // This tells the server that the data we are sending ('Content-Type') is in JSON format ('application/json')

        body: body,
        // Attaches the request body
        // In this case, body (the second one) is the actual data sent to the Gemini API
      );

      // ---- Handle Gemini response ----
      if (response.statusCode == 200) {
        // Check if the response was successful (200 is code for 'OK')

        final jsonResponse = jsonDecode(response.body);
        // Decodes the JSON response (parses the JSON response into a Dart object)
        // response.body contains the raw JSON response as a string
        // The parsed (decoded) JSON is stored in the 'jsonResponse' variable

        setState(() {
          // setState() is used to rebuild the UI when the state changes

          if (jsonResponse['candidates'] != null &&
              jsonResponse['candidates'].isNotEmpty) {
            // The API response returns a JSON object with a "candidates" field
            // This field is expected to be a list of possible generated responses
            // We have to check if the response contains a candidates field that is not null (jsonResponse['candidates'] != null)
            // AND (&&) that it is not empty (jsonResponse['candidates'].isNotEmpty)
            // If both conditions are true, it means there is at least one candidate response available

            final parts = jsonResponse['candidates'][0]['content']['parts']
                as List<dynamic>;
            // What we do is take the first candidate (jsonResponse['candidates'][0]) and access its "content" property
            // Inside "content" there is a "parts" array that holds segments of the response
            // We cast "parts" as a List<dynamic> and store the result in the "parts" variable
            // A List<dynamic> is a list that can hold any type of objects

            _response = parts.map((p) => p['text']).join('\n');
            // We then extract the text from each part by mapping over parts and getting the "text" field from each element
            // These text segments are joined together (.join()) with newline characters (\n) to form a single string
            // This single string is stored in the "_response" variable, which is the text that will be displayed on the screen
          } else {
            // If candidates is null or empty, it means the API did not return any responses
            _response = 'The model did not receive an answer';
          }
        });
      } else {
        // If the response was NOT successful

        setState(() {
          // setState() is used to rebuild the UI when the state changes

          _response = 'Error API: ${response.statusCode}\n${response.body}';
          // This line updates the variable _response, setting it to a string that shows:
          // The error status code from the HTTP response (response.statusCode) (for example, 404 or 500)
          // The raw response body (response.body), which might contain an error message or details from the server
          // ${...} is the way Dart inserts variables inside a string
          // The \n adds a new line between the status code and the body for readability reasons
        });
      }
    } catch (e) {
      // Block meant to handle exceptions
      // e holds the error object (the exception thrown), which can be any kind of error (for example, network failure)

      setState(() {
        // setState() is used to rebuild the UI when the state changes

        _response = 'Error in the request: $e';
        // Updates _response with an error message including the actual error object e
      });
    } finally {
      // The finally block always runs after the try and catch blocks regardless of success or error

      setState(() {
        // setState() is used to rebuild the UI when the state changes

        _loading = false;
        // In this case, it always stops showing the loading spinner
      });
    }
  }

  // ----------------------  Dispose sources ----------------------
  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the dispose() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  void dispose() {
    // The dispose method is automatically called by Flutter when the widget is permanently removed from the widget tree

    _controller.dispose();
    // Calls the dispose() method on _controller
    // _controller will be an object that holds resources and needs explicit cleanup to avoid memory leaks
    // Always dispose of controllers to free memory

    super.dispose();
    // Calls the parent class dispose() method to ensure any other cleanup in the base class also runs properly
  }

  // ---------------------- Build the screen interface ----------------------
  // This function defines what the screen looks like, it is basically method used to build the UI of this widget
  // The parameter context gives access to theme, size, etc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a basic page layout that creates an structure for the screen

      appBar: AppBar(
          // Top bar of the app, often used for navigation or titles

          title: const Text('Gemini AI chat integration')),
      // Title displayed in the app bar

      body: Padding(
        // 'body' refers to the main content area of the screen

        padding: const EdgeInsets.all(20),
        // Adds padding of 20 px to all sides (top, bottom, left, right)
        // If you wanted to add padding on top and bottom you would use EdgeInsets.symmetric(vertical: 24.0);
        // If you wanted to add padding on left and right you would use EdgeInsets.symmetric(horizontal: 24.0);
        // You can also combine both, for example EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        // You can add padding on individual sides, for example:
        // EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0, right: 20.0)
        // EdgeInsets.only(left: 8.0, top: 10.0)

        child: Column(
          // Stacks widgets vertically

          children: [
            // List of child widgets that will be stacked vertically

            const Text(
              'Write a message so Gemini can answer you:',
              // Text displayed on the screen, will be seen by the user

              style: TextStyle(
                  // Applies custom styling to the text

                  fontWeight: FontWeight.bold,
                  // Makes the text bold by applying a heavier font weight
                  // You can also use values like FontWeight.w600 or just w600
                  // A list would be w100 (thin), w200 (extra light), w300 (light), w400 or FontWeight.normal (normal),
                  // w500 (medium), w600 (semi-bold), w700 or FontWeight.bold (bold), w800 (extra bold), w900 (heaviest)

                  fontSize: 18
                  // Sets the text size to 18 px
                  // As always, this is just an example value

                  ),
            ),

            const SizedBox(height: 12),
            // Adds vertical space between the icon and the text
            // This is just an example value of 12 px, you can use any value you want
            // This is just an aesthetic choice

            TextField(
              // Creates a text input field widget where the user can type text

              controller: _controller,
              // _controller is an instance used to read, modify or listen to the text typed in the field

              maxLines: 3,
              // Sets the maximum number of visible lines for the text input
              // In this case, the TextField will expand up to 3 lines vertically when the user types more text
              // 3 is just an example value, use the value you want

              decoration: const InputDecoration(
                // Provides visual decoration and styling for TextField

                border: OutlineInputBorder(),
                // Adds a border around the text field shaped as an outline (basically a rectangle with edges)
                // This visually distinguishes the input area

                labelText: 'Your message',
                // Adds a label text that appears inside the border or above it
                // Visual cue to let the user know where to type their prompt
              ),
            ),

            const SizedBox(height: 12),
            // Adds vertical space between the icon and the text
            // This is just an example value of 12 px, you can use any value you want
            // This is just an aesthetic choice

            ElevatedButton(
              onPressed: _loading ? null : _sendPrompt,
              // This line defines what happens when the user presses the button
              // _loading is the variable we created to
              // ? null : _sendPrompt is the ternary operator, which chooses between two options depending on _loading
              // These two options are 'null' or '_sendPrompt'
              // A ternary operator works with the following structure:
              // condition ? valueIfTrue : valueIfFalse
              // This means that, in this case, if _loading == true, onPressed = null
              // And if _loading == false, onPressed = _sendPrompt

              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Send'),
              // Uses a ternary operator to decide what widget to display as the child of the ElevatedButton
              // A ternary operator works with the following structure:
              // condition ? valueIfTrue : valueIfFalse
              // This means that, in this case, if _loading == true, it means it is trying to establish a connection with the Gemini AI and send your prompt
              // It shows a loading spinner (CircularProgressIndicator), this spinner is set to be white but you can adjust it to your liking
              // If _loading == false, it is not in the process of sending the prompt right now, so it shows the text 'Send'
              // This indicates the user they can tap on the button to send their prompt
            ),

            const SizedBox(height: 20),
            // Adds vertical space between the icon and the text
            // This is just an example value of 20 px, you can use any value you want
            // This is just an aesthetic choice

            Expanded(
              // Widget that takes up all available space in the parent (usually inside a column or row)

              child: SingleChildScrollView(
                // Wraps the content in a scrollable container, allowing to scroll vertically if it overflows
                // Useful when _response (in this case) is really long and does not fit on the screen

                child: Text(
                  // Displays the text on the screen

                  _response,
                  // Variable that holds either the Gemini answer or the error message

                  style: const TextStyle(
                      // Applies custom styling to the text (to the title in this case)

                      fontSize: 16),
                  // Sets the text size to 16 px
                  // As always, this is just an example value
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
