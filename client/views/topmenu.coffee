views = NS "Edulaboro.views"

class views.Topmenu extends Edulaboro.View

  className: "topmenu"

  constructor: ->
    super
    @o = {}
    @o.buttonName = "New Document"

    this.model.on "change", =>
      if this.getModelMode() is "no_editor"
        @o.buttonName = "New Document"

      this.render() 

  events: ->
    "click button.js-addHideEditor": "addHideEditor"

  addHideEditor: ->
    if this.getModelMode() is "no_editor"
      @editorInstance = new wysihtml5.Editor "js-wysihtml5-textarea",
        toolbar:      "wysihtml5-toolbar",
        parserRules:  wysihtml5ParserRules,
        autoLink: true,
        style: true
      this.model.set mode: "editor"
      @o.buttonName = "Close Document"

    else
      this.model.set mode: "no_editor"
      @o.buttonName = "New Document"
      
    this.render()

  getModelMode: ->
    return this.model.get("mode")

  render: ->
    @$el.html @renderTemplate "topmenu", @o