Edulaboro = NS "Edulaboro"
views = NS "Edulaboro.views"
helpers = NS "Edulaboro.helpers"
models = NS "Edulaboro.models"

$ ->
    
  # car = new models.Cars

  # button = new views.Button model: car
  # button.render()
  # $(".container").append button.el

  # carview = new views.CountView model: car
  # carview.render()
  # $(".container").append carview.el
  
  editorToolbar = new views.WysihtmlToolbar
  editorToolbar.render()
  $(".wysihtml5-container").append editorToolbar.el

  editor = new views.WysihtmlForm
  editor.render()
  $(".wysihtml5-container").append editor.el