// --------IMPORTANT!!!!--------
// For Node.js to work, you have to FIRST run the server (this file) and THEN run the Flutter file that calls this server

const express = require('express');  // This line imports the Express.js framework, which is a tool that helps create web servers in Node.js
                                     // Without this tool you would not be able to build a web server
const app = express();   // Creates an Express application instance, this will handle all the logic of the server
const port = 3000;  // Server port, in this case is 3000 but you can change it to your own value
                    // This port is where the server will listen for incoming connections

// Now we define a route for HTTP GET requests
// 'app.get' handles GET requests
// '/status' is the URL path, for example, http://localhost:3000/status
// 'req' is the incoming request data (not used here)
// 'res' is the response object to send data back
// 'res.send(...)' sends text back to the client
app.get('/status', (req, res) => {
  res.send('Node.js backend running for LG!');
});

app.listen(port, () => {
  console.log(`LG Node.js backend listening at http://localhost:${port}`); // Starts the server and makes it listen on port 3000
                                                                           // The log is used to confirm it is working
});
