models = NS "Edulaboro.models"

class models.Editor extends Backbone.Model

  defaults:
    mode: "no_editor"
    documentTitle: "Untitled Document"
    documentText: ""

  url: "/documents"

  saveDocument: (title, document) ->
    if title isnt "" and document isnt ""
      @save
        documentTitle: title
        documentText: document
        timestamp: new Date().getTime()
        success: -> 
          console.log "YES"
        error: ->
          console.log "NO"
      console.log "Saved: "
      console.log @.toJSON()
    else console.log "Title or document can't be blank!"

  saveEditedDocument: (title, document) ->
    if title isnt "" and document isnt ""
      @save
        documentTitle: title
        documentText: document
        editTimestamp: new Date().getTime()
        success: -> 
          console.log "YES"
        error: ->
          console.log "NO"
      console.log "Edit Saved: "
      console.log @.toJSON()
    else console.log "Title or document can't be blank!"

class models.Document extends Backbone.Model
  
  defaults:
    type: "document"
    value: 
      title: "Untitled Document"

  initialize: ->
    console.log 'Document model has been initialized'
    console.log @.toJSON()


class models.Documents extends Backbone.Collection
  model: models.Document
  url: "/documents"

  # We want to wait that all the models are created before render our collection
  initialize: ->
    @.isFetched = false
    @.on "reset", @.onReset, @
    console.log "isFetched: "+ @.isFetched

  parse: (response) ->
    new models.Document response for response in response.alldocs

  onReset: ->
    @.isFetched = true
    console.log "RESET TRUE"

  # We want to sort the collection in descending order with timestamp as id
  comparator: (model) ->
    return -model.toJSON().value.timestamp

# Add "dummy model" for controlling views, this is quite ugly but we will go with this for now
class models.ViewHelper extends Backbone.Model
  defaults:
    viewRemoved: false
    closeAllOtherViews: false

