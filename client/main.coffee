Edulaboro = NS "Edulaboro"
views = NS "Edulaboro.views"
helpers = NS "Edulaboro.helpers"
models = NS "Edulaboro.models"

$ ->
  editorEditModel = new models.Editor
  editorNewDocumentModel = new models.Editor
  documentCollection = new models.Documents
  documentModel = new models.Document
  viewHelperModel = new models.ViewHelper

  topmenu = new views.Topmenu 
    model: editorNewDocumentModel
  topmenu.render()
  $(topmenu.el).insertBefore ".container"

  # This is ugly and need to do prettier
  editorEditView = new views.EditWysihtmlEditor 
    el: ".js-edit-document-container"
    collection: documentCollection
    model: editorEditModel
    helpermodel: viewHelperModel
  editorEditView.render()

# This is ugly and need to do prettier
  editorNewDocumentView = new views.NewWysihtmlEditor 
    el: ".js-new-document-container"
    model: editorNewDocumentModel
    documentmodel: documentModel
    collection: documentCollection 
  editorNewDocumentView.render()

  documents = new views.Documents
    el: ".all-documents"
    collection: documentCollection
    model: editorEditModel
    helpermodel: viewHelperModel
  documents.render()
