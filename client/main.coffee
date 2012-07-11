Edulaboro = NS "Edulaboro"
views = NS "Edulaboro.views"
helpers = NS "Edulaboro.helpers"
models = NS "Edulaboro.models"

$ ->
  
  editorModel = new models.Editors

  topmenu = new views.Topmenu model: editorModel
  topmenu.render()
  $(topmenu.el).insertBefore ".container"

  editor = new views.WysihtmlEditor model: editorModel
  editor.render()
  $(".container").append editor.el