views = NS "Edulaboro.views"

class views.NewWysihtmlEditor extends Edulaboro.View

  constructor: ->
    super
    @.model.on "change:mode", =>

      console.log "Mode changed in editor view to: "+ @.getModelMode()

      if @.getModelMode() is "no_editor"
        @$el.addClass "display_none"
        @$el.removeClass "display_block"

      else if @.getModelMode() is "editor"
        
        if !@editorInstance
          @editorInstance = @$("#js-new-wysihtml5-textarea").wysihtml5
            toolbar:      "wysihtml5-toolbar"
            parserRules:  wysihtml5ParserRules
            autoLink: true
            style: true
            html: true
        
        @$(".js-new-document-name").val @.model.get("documentTitle")
        @editorInstance.data("wysihtml5").editor.setValue @.model.get("documentText")
        
        console.log "Editor Model: " 
        console.log @.model.toJSON()
        console.log "Document Model: " 
        console.log @.options.documentmodel.toJSON()

        @$el.addClass "display_block"
        @$el.removeClass "display_none"


  events: ->
    "click a.js-cancel-document-button": "cancelDocument"
    "click a.js-save-document-button": "saveDocument"
    "focus input.js-new-document-name": "selectInputText"

  cancelDocument: ->
    if @.getModelMode() is "editor"
      @.model.set mode: "no_editor"

  saveDocument: ->
    @title = @$(".js-new-document-name").val()
    @val = @$("#js-new-wysihtml5-textarea").val()
    @.model.saveDocument @title, @val
    @.model.set @.model.defaults
    @.collection.unshift
      value:
        title: @title
        document: @val

  selectInputText: ->
    @$(".js-new-document-name").select()

  
  getModelMode: ->
    return @.model.get("mode")

  render: ->
    @$el.html @renderTemplate "new-editor"

class views.EditWysihtmlEditor extends Edulaboro.View

 constructor: ->
    super
    @.model.on "change", =>
      if @.model.get("mode") is "no_editor"
        @$el.addClass "display_none"
        @$el.removeClass "display_block"
      else if @.getModelMode() is "editor"
        if !@editorInstance
          @editorInstance = @$("#js-edit-wysihtml5-textarea").wysihtml5
            toolbar:      "wysihtml5-toolbar"
            parserRules:  wysihtml5ParserRules
            autoLink: true
            style: true
            html: true
        @$(".js-edit-document-name").val @.model.get("documentTitle")
        @editorInstance.data("wysihtml5").editor.setValue @.model.get("documentText")
        @$el.addClass "display_block"
        @$el.removeClass "display_none"


  events: ->
    "click a.js-cancel-document-button": "cancelDocument"
    "click a.js-save-edited-document-button": "saveEditedDocument"

  cancelDocument: ->
    if @.model.get("mode") is "editor"
      @.model.set mode: "no_editor"
      @.options.helpermodel.set 
        id: @.model.get("id")
        viewRemoved: true

  saveEditedDocument: ->
    @title = @$(".js-edit-document-name").val()
    @val = @$("#js-edit-wysihtml5-textarea").val()
    @documentModel = @.collection.get @.model.get "id"
    @documentModel.set
      value:
        title: @title 
        document: @val
    @.model.saveEditedDocument @title, @val
    @.model.set 
        mode: "no_editor"

  getModelMode: ->
    return @.model.get("mode")

  render: ->
    @$el.html @renderTemplate "edit-document-editor"