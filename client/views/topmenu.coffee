views = NS "Edulaboro.views"

class views.Topmenu extends Edulaboro.View

  className: "topmenu"

  constructor: ->
    super
    @o = {}
    @o.buttonName = "New Document"

    this.model.on "change:mode", =>
      if this.getModelMode() is "no_editor"
        @o.buttonName = "New Document"

      else if this.getModelMode() is "editor"
        @o.buttonName = "Close Document"

      this.render() 

  events: ->
    "click button.js-addHideEditor": "addHideEditor"

  addHideEditor: ->
    if this.getModelMode() is "no_editor"
      this.model.set 
        mode: "editor"
        newDocument: true

    else if this.getModelMode() is "editor"
      this.model.set 
        mode: "no_editor"
        newDocument: false
      

  getModelMode: ->
    return this.model.get("mode")

  render: ->
    @$el.html @renderTemplate "topmenu", @o