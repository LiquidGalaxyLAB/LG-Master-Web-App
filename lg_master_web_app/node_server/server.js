// To be uploaded on Render so it can be used on an Android app
const express = require('express');
const app = express();
const port = 3000;

app.get('/status', (req, res) => {
  res.send('Node.js server is running smoothly!');
});

app.listen(port, () => {
  console.log(`Node.js server listening at http://localhost:${port}`);
});
