dbHost = "127.0.0.1"
dbport = 5984
dbName = "test"

rootDir = __dirname + "/../"
fs = require "fs"
cradle = require "cradle"

db = new cradle.Connection().database dbName

# Check if a database exists
# db.exists (err,exists) ->
#   if err
#     console.log err
#   else if exists
#     console.log "Database exists"
#   else
#     console.log "Database doesnt exist"
#     db.create()

# Just an example about Couch DB view
# db.save "_design/getDocuments",
#   all:
#     map: (doc) ->
#       if doc.type is "document" 
#         emit doc._id, doc

# db.get "test", (err,doc) ->
#   if err
#     console.log err
#   else 
#     console.log doc


readTemplateStrings = ->
  clientTemplates = fs.readdirSync rootDir + "views/client"
  str = ""
  for tmplName in clientTemplates when tmplName.match /hbs$/
    id  = tmplName.split(".")[0]
    data = fs.readFileSync rootDir + "views/client/" + tmplName
    str += "<script type='text/handlebars' id='template-#{id}'>#{data.toString()}</script>"
  return str

  console.log clientTemplates

getAllDocuments = ->
  response = {}
  db.view 'getDocuments/all', (err, res) ->
    if err
      response = err
    else
      response = res
  return response

module.exports = (app) ->
	app.get "/", (req, res) ->
		res.render "index",
      clientTemplates: readTemplateStrings()
      documentResponse: getAllDocuments()

  # Save editor data to Couch DB
  # TODO: Validate data, add unique id, add proper error messages etc.
  app.post "/documents", (req, res) ->
    db.save req.body.documentName,
      type: "document"
      title: req.body.documentName
      doc: req.body.documentText,
      (err, res) ->
        if err
          console.log err
        else
          console.log res

  # TODO: Everything :)
  app.get "/documents", (req, res) ->
    console.log req