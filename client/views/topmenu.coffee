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

      @.render() 

  events: ->
    "click button.js-addHideEditor": "addHideEditor"

  addHideEditor: ->
    if @.getModelMode() is "no_editor"
      @.model.set 
        mode: "editor"

    else if @.getModelMode() is "editor"
      @.model.set 
        mode: "no_editor"
      

  getModelMode: ->
    return @.model.get("mode")

  render: ->
    @$el.html @renderTemplate "topmenu", @o