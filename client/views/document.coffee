views = NS "Edulaboro.views"

class views.Document extends Edulaboro.View

  className: "document js-document display_none"

  constructor: ->
    super
    console.log "I'am a document view" 
    console.log @.model.toJSON()
    if @$el.hasClass("display_none")
      @$el.addClass "display_block"
      @$el.removeClass "display_none"

    else if @$el.hasClass("display_block")
      @$el.addClass "display_none"
      @$el.removeClass "display_block"
    
    @render()

    @.model.on "change", =>
      console.log "Document Model changed!"
  
  events: ->
    "click button.js-close-document-btn": "closeView"
    "click button.js-edit-document-btn": "editModel"

  closeView: (event) ->
    @.options.helpermodel.set 
      id: @.model.get("id")
      viewRemoved: true
    @$el.remove()

  editModel: (event) ->
    @modelID = @.model.get("id")
    @.options.editorModel.set 
      mode:"no_editor"
    @document = @.model.toJSON()
    @.options.editorModel.set 
      documentTitle: @document.value.title
      documentText: @document.value.document
      id: @document.id
      mode: "editor"
    @$el.remove()

  render: ->
    @$el.html @renderTemplate "document", @.model.toJSON()