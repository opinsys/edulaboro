views = NS "Edulaboro.views"

class views.WysihtmlEditor extends Edulaboro.View

  className: "new-document-container display_none"

  constructor: ->
    super
    this.model.on "change:mode", =>
      if this.getModelMode() is "no_editor"
        @$el.addClass "display_none"
        @$el.removeClass "display_block"
      else if this.getModelMode() is "editor"
        if !@editorInstance
          @editorInstance = @$("#js-wysihtml5-textarea").wysihtml5
            toolbar:      "wysihtml5-toolbar"
            parserRules:  wysihtml5ParserRules
            autoLink: true
            style: true
            html: true

        @$el.addClass "display_block"
        @$el.removeClass "display_none"

  events: ->
    "click a.js-cancel-document-button": "cancelDocument"
    "click a.js-save-document-button": "saveDocument"

  cancelDocument: ->
    if this.getModelMode() is "editor"
      this.model.set mode: "no_editor"

  saveDocument: ->
    @title = @$(".document-name").val()
    @val = @$("#js-wysihtml5-textarea").val() 
    this.model.saveDocument @title, @val

  render: ->
    @$el.html @renderTemplate "wysihtml5-editor"