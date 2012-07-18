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
        timestamp: new Date().getTime()
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
      timestamp: ""
      title: "Untitled Document"
      document: ""

  initialize: ->
    console.log 'Document model has been initialized'
    console.log @.toJSON()


class models.Documents extends Backbone.Collection
  model: models.Document
  url: "/documents"

  # We want to wait that all the models are created before render our collection
  initialize: ->
    @.isFetched = false
    @.bind "reset", @.onReset, @
    console.log "isFetched: "+ @.isFetched

  parse: (response) ->
    new models.Document response for response in response.alldocs

  onReset: ->
    @.isFetched = true
    console.log "RESET TRUE"

  # We want to sort the collection in descending order with timestamp as id
  comparator: (model) ->
    @temp = model.get("value")
    return -@temp.timestamp