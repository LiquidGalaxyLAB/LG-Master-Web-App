// -------------------------------------------- NODEJS SERVER --------------------------------------------
// This server is external to the project
// In this case, I uploaded it in Render, a cloud application platform, so I could use it
// This file and the package.json files are not used directly, the REMOTE server is used directly
// The files are just here on the project so you can check what a server looks like

// ---------------------- Server configuration ----------------------
const express = require('express'); // Import the Express library, used to create a simple web server in Node.js
// You can also build a server using Node.js built-in http module, but it requires more code 

const app = express(); // Create an INSTANCE of an Express application instance and stores it in the 'app' variable
// This instance will be used to define routes and start the server
// An instance is a specific and usable object created from a class or constructor that contains its own data and behavior

const port = 3000; // Define the port number the server will listen on when running locally
// In this case, http://localhost:3000
// You can use any port you want, but make sure it ranges from 1024 to 49151
// Ports from 0 to 1023 are used for system services (HTTP, SSH, etc.)
// Ports from 49152 to 65535 are used for tetsing
// Also make sure the port you use is not being used by another program in your computer 

// ---------------------- Message from the server ----------------------
app.get('/status', (req, res) => {
// Defines a route in the Express app that will listen for HTTP GET requests to the /status endpoint
// When a client accesses /status, this function will run
// 'req' contains information about the incoming request (headers, URL, etc.)
// 'res' is used to send a response back to the client

  res.send('Node.js server is running smoothly!');
  // Message that will be sent as a response to indicate that the server is up and working
  // This is the message that will be displayed to the user, as specified in the nodejs.dart file
});

// ---------------------- Start the server ----------------------
app.listen(port, () => {
  // Starts the server and have it listen on the specified port (in this case 3000) for incoming connections
  
  console.log(`Node.js server listening at http://localhost:${port}`);
  // Prints a message to the console, showing the URL (including the port) where the server can be accessed locally
  // This line is NOT shown to the user
  // It will only be shown in the server console or terminal where the Node.js app is running
});
