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
#         emit doc.type, title: doc.title, document: doc.doc

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

getAllDocuments = (cb) ->
  db.view 'getDocuments/all', cb

module.exports = (app) ->
	app.get "/", (req, res) ->
		res.render "index",
      clientTemplates: readTemplateStrings()

  # Save editor data to Couch DB
  # TODO: Validate data, add unique id, add proper error messages etc.
  app.post "/documents", (req, res) ->
    db.save req.body.documentTitle,
      type: "document"
      title: req.body.documentTitle
      doc: req.body.documentText,
      (err, res) ->
        if err
          console.log err
        else
          console.log res

  # TODO: Lots of things...
  app.get "/documents", (req, res) ->
    getAllDocuments (err, documents) ->
      if err
        res.json
          error: err
      else
        res.json
          alldocs: documents

  # TODO: Lots of things...
  app.get "/document[/id]", (req, res) ->
    res.send "aaaa"

  # TODO: Lots of things...
  app.put "/documents/id", (req, res) ->
    db.merge req.body.documentTitle,
      title: req.body.documentTitle
      doc: req.body.documentText,
      (err, res) ->
        if err
          console.log err
        else
          console.log res
