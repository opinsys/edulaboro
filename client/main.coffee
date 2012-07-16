Edulaboro = NS "Edulaboro"
views = NS "Edulaboro.views"
helpers = NS "Edulaboro.helpers"
models = NS "Edulaboro.models"

$ ->
  editorModel = new models.Editor
  documentCollection = new models.Documents

  topmenu = new views.Topmenu model: editorModel
  topmenu.render()
  $(topmenu.el).insertBefore ".container"

  editor = new views.WysihtmlEditor 
    el: ".js-new-document-container"
    collection: documentCollection
    model: editorModel
  editor.render()

  documents = new views.Documents
    el: ".all-documents"
    collection: documentCollection
    model: editorModel
  documents.render()
