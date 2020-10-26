// Require express and body-parser
const express = require("express")
const bodyParser = require("body-parser")
const shell = require("shelljs")

// Initialize express and define a port
const app = express()
const PORT = 3000

// Tell express to use body-parser's JSON parsing
app.use(bodyParser.json())

// Root route for healthchecks
app.get('/', (req, res) => {
    res.status(422).send('ONLINE');
  });

// Post route for Webhook
app.post("/payload", (req, res) => {
  res.status(200).end() //Respond to post

  // The code below was used for executing scripts on original project 
  let pusher_name = req.body.pusher.name
  let repo_name = req.body.repository.name
  let ssh_url  = req.body.repository.ssh_url
  shell.exec (`sh ./build.sh ${repo_name} ${pusher_name} ${ssh_url}`)
})


// Start express server
app.listen(PORT, () => console.log(` Server running on port ${PORT}`))