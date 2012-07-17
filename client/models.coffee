models = NS "Edulaboro.models"

class models.Editor extends Backbone.Model

  defaults:
    mode: "no_editor"
    documentTitle: "Untitled Document"
    documentText: ""

  url: "/documents"

  saveDocument: (title, text) ->
    if title isnt "" and text isnt ""
      @save
        documentTitle: title
        documentText: text
        success: -> 
          console.log "YES"
        error: ->
          console.log "NO"
      console.log @.toJSON()
    else console.log "Title and Text can't be blank!"

class models.Document extends Backbone.Model
  
  defaults:
    type: "document"
    value:
      title: "Untitled Document"
      document: ""

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