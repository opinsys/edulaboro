express = require "express"
hbs = require "hbs"
piler = require "piler"
fs = require "fs"

rootDir = __dirname + "/../"
clientTmplDir = rootDir + "/views/client/"

defaults =
  listenPort: 8000

try
  config = JSON.parse fs.readFileSync rootDir + "config.json"
catch e
  config = {}
  console.error "Couldn't load config.json. Using defaults."

for k, v of defaults
  config[k] ?= v

app = express.createServer()
css = piler.createCSSManager()
js = piler.createJSManager()

css.bind app
js.bind app

app.configure "development", ->
  # js.liveUpdate(css)

app.configure ->
  app.use express.bodyParser()

# Connect Handlebars to Piler Asset Manager
  hbs.registerHelper "renderScriptTags", (pile) ->
    js.renderTags pile
  hbs.registerHelper "renderStyleTags", (pile) ->
    css.renderTags pile

  app.use express.static rootDir + '/public'
  app.set "views", rootDir + "views"
  app.set 'view engine', 'hbs'

  js.addFile rootDir + "/client/vendor/jquery.js"
  js.addFile rootDir + "/client/vendor/handlebars.js"
  js.addFile rootDir + "/client/vendor/underscore.js"
  js.addFile rootDir + "/client/vendor/backbone.js"
  js.addFile rootDir + "/public/vendor/bootstrap-wysihtml5/wysihtml5.js"
  js.addFile rootDir + "/public/vendor/bootstrap/js/bootstrap.min.js"
  js.addFile rootDir + "/public/vendor/bootstrap-wysihtml5/bootstrap-wysihtml5.js"
  js.addFile rootDir + "/public/vendor/bootstrap-wysihtml5/advanced.js"
  js.addFile rootDir + "/client/helpers.coffee"
  js.addFile rootDir + "/client/models.coffee"
  js.addFile rootDir + "/client/baseview.coffee"
  js.addFile rootDir + "/client/views/editor.coffee"
  js.addFile rootDir + "/client/views/documents.coffee"
  js.addFile rootDir + "/client/views/document.coffee"
  js.addFile rootDir + "/client/views/topmenu.coffee"
  js.addFile rootDir + "/client/main.coffee"

  css.addFile rootDir + "/public/vendor/bootstrap/css/bootstrap.min.css"
  css.addFile rootDir + "/public/vendor/bootstrap/css/bootstrap-responsive.min.css"
  css.addFile rootDir + "/public/vendor/bootstrap-wysihtml5/bootstrap-wysihtml5.css"

  css.addFile rootDir + "/client/styles/layout.styl"
  css.addFile rootDir + "/client/styles/theme.styl"

# Add routes and real application logic
require("./routes") app

app.listen config.listenPort, ->
	console.log "Listening port: #{ config.listenPort }"  