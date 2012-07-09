module.exports = (app) ->
	app.get "/", (req, res) ->
		res.send "Hello world!"

	app.get "/test", (req, res) ->
		res.send "Hello, this is test-page"