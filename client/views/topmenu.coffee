views = NS "Edulaboro.views"

class views.Topmenu extends Edulaboro.View

  className: "topmenu"

  constructor: ->
    super
    @o = {}
    @o.buttonName = "New Document"

    @.model.on "change:mode", =>
      if @.getModelMode() is "no_editor"
        @o.buttonName = "New Document"

      else if @.getModelMode() is "editor"
        @o.buttonName = "Close Document"
        @.options.helpermodel.set
          closeAllOtherViews: false
      
      @.render() 

    @.options.helpermodel.on "change:closeAllOtherViews", =>
      # Close editor before opening any other view
      if @.options.helpermodel.get("closeAllOtherViews") and @.getModelMode() is "editor"
        @.model.set 
          mode: "no_editor"

  events: ->
    "click button.js-addHideEditor": "addHideEditor"

  addHideEditor: ->
    if @.getModelMode() is "no_editor"
      @.options.helpermodel.set
        closeAllOtherViews: true
      @.model.set 
        mode: "editor"

    else if @.getModelMode() is "editor"
      @.model.set 
        mode: "no_editor"
      

  getModelMode: ->
    return @.model.get("mode")

  render: ->
    @$el.html @renderTemplate "topmenu", @o