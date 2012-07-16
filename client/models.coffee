models = NS "Edulaboro.models"

class models.Editor extends Backbone.Model

  defaults:
    mode: "no_editor"
    id: ""
    documentTitle: "Untitled Document"
    documentText: ""

  url: "/documents"

  saveDocument: (title, text) ->
    @save
      documentTitle: title
      documentText: text,
      success: (response) -> 
        console.log response
    console.log @.toJSON()

class models.Document extends Backbone.Model
  
  defaults:
    type: "document"

  initialize: ->
    console.log 'Document model has been initialized'
    console.log @.toJSON()


class models.Documents extends Backbone.Collection
  model: models.Document
  url: "/documents"

  initialize: ->
    @.isFetched = false
    @.bind "reset", @.onReset, @

  parse: (response) ->
    new models.Document response for response in response.alldocs

  onReset: ->
    @.isFetched = true
    console.log "RESET TRUE"