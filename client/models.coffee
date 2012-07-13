models = NS "Edulaboro.models"

class models.Editors extends Backbone.Model

  defaults:
    mode: "no_editor"

  url: "/documents"

  saveDocument: (name,val) ->
    @save
      documentName: name
      documentText: val

class models.Document extends Backbone.Model

  initialize: ->
    console.log 'Document model has been initialized'
    console.log @.toJSON()

class models.Documents extends Backbone.Collection
  model: models.Document
  url: "/documents"

  initialize: ->
    console.log 'Document Collection has been initialized'