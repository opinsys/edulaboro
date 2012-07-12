Edulaboro = NS "Edulaboro"
views = NS "Edulaboro.views"
helpers = NS "Edulaboro.helpers"
models = NS "Edulaboro.models"

$ ->
  editorModel = new models.Editors

  topmenu = new views.Topmenu model: editorModel
  topmenu.render()
  $(topmenu.el).insertBefore ".container"

  editor = new views.WysihtmlEditor 
    el: ".js-new-document-container"
    model: editorModel
  editor.render()