models = NS "Edulaboro.models"

class models.Editors extends Backbone.Model

  defaults:
    mode: "no_editor"

  url: "/documents"

  saveDocument: (name,val) ->
    @save
      documentName: name
      documentText: val