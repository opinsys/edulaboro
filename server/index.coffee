express = require "express"

app = express.createServer()

app.configure ->
  app.use express.bodyParser()

# Add routes and real application logic
require("./routes") app

app.listen 8000, ->
	console.log "Listening port 8000"