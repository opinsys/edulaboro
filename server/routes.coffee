rootDir = __dirname + "/../"
fs = require "fs"


readTemplateStrings = ->
  clientTemplates = fs.readdirSync rootDir + "views/client"
  str = ""
  for tmplName in clientTemplates when tmplName.match /hbs$/
    id  = tmplName.split(".")[0]
    data = fs.readFileSync rootDir + "views/client/" + tmplName
    str += "<script type='text/handlebars' id='template-#{id}'>#{data.toString()}</script>"
  return str

  console.log clientTemplates



module.exports = (app) ->
	app.get "/", (req, res) ->
		res.render "index",
      clientTemplates: readTemplateStrings()