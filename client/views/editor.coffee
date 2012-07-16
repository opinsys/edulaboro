views = NS "Edulaboro.views"

class views.WysihtmlEditor extends Edulaboro.View

  className: "new-document-container display_none"

  constructor: ->
    super
    @.model.on "change:mode", =>

      console.log "Mode changed in editor view to: "+ @.getModelMode()

      if @.getModelMode() is "no_editor"
        console.log "New doc: "+ @.model.get("newDocument")
        @$el.addClass "display_none"
        @$el.removeClass "display_block"

      else if @.getModelMode() is "editor"
        
        if !@editorInstance
          @editorInstance = @$("#js-wysihtml5-textarea").wysihtml5
            toolbar:      "wysihtml5-toolbar"
            parserRules:  wysihtml5ParserRules
            autoLink: true
            style: true
            html: true
          @$(".js-document-name").val @.model.get("documentTitle")
          @editorInstance.data("wysihtml5").editor.setValue @.model.get("documentText")
        
        console.log "New doc: "+ @.model.get("newDocument")
        console.log "ID: "+ @.model.get("id")

        # If we edit document
        if !@.model.get("newDocument") and @.model.get("id") isnt ""
          @$(".js-document-name").val @.model.get("documentTitle")
          @editorInstance.data("wysihtml5").editor.setValue @.model.get("documentText")
        
        # Else if we want to create new document
        else if @.model.get("newDocument") and @.model.get("id") isnt ""
          console.log "Reset to defaults"

        @$el.addClass "display_block"
        @$el.removeClass "display_none"


  events: ->
    "click a.js-cancel-document-button": "cancelDocument"
    "click a.js-save-document-button": "saveDocument"

  cancelDocument: ->
    if @.getModelMode() is "editor"
      @.model.set 
        mode: "no_editor"
        newDocument: false

  saveDocument: ->
    @title = @$(".document-name").val()
    @val = @$("#js-wysihtml5-textarea").val() 
    @.model.saveDocument @title, @val
    @.model.set 
        mode: "no_editor"
        newDocument: false

  getModelMode: ->
    return @.model.get("mode")

  render: ->
    @$el.html @renderTemplate "wysihtml5-editor"