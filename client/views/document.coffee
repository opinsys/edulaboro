views = NS "Edulaboro.views"

class views.Document extends Edulaboro.View

  className: "document js-document display_none"

  constructor: ->
    super
    console.log "I'am a document view" 
    console.log @.model.toJSON()
    console.log "My helper model is:"
    console.log @.options.helpermodel.toJSON()
    if @$el.hasClass("display_none")
      @$el.addClass "display_block"
      @$el.removeClass "display_none"

    else if @$el.hasClass("display_block")
      @$el.addClass "display_none"
      @$el.removeClass "display_block"
    
    @render()

    @.model.on "change", =>
      console.log "Document Model changed!"


    @.options.helpermodel.on "change:closeAllOtherViews", =>
      console.log "closeAllOtherViews in Document view: " + @.options.helpermodel.get("closeAllOtherViews")
      # Close view before opening new one
      if @.options.helpermodel.get("closeAllOtherViews")
        @.options.helpermodel.set
          viewRemoved: true
          id: @model.get("id")
        @$el.remove()

    @.options.helpermodel.set
      closeAllOtherViews: false

  events: ->
    "click button.js-close-document-btn": "closeDocument"
    "click button.js-edit-document-btn": "editDocument"
    "click button.js-remove-document-btn": "removeDocument"

  closeDocument: (event) ->
    @.options.helpermodel.set
      viewRemoved: true
      id: @model.get("id")
    @$el.remove()

  editDocument: (event) ->
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

  removeDocument: (event) ->
    @modelID = @.model.get("id")
    console.log "Delete document with id: "+ @modelID

    # For now lets do model destroy confirmation just with confirm (it's ugly and wrong, yes...)
    if confirm "Delete document with title: "+ @.model.toJSON().value.title + " \nID: "+ @modelID
      @$el.remove()
      @.model.destroy
        headers:
          revision: @.model.toJSON().value.revision
        success: (msg) ->
          console.log "Document destroyed: "
          console.log msg
        error: (err) ->
          console.log "Document destroy error: "
          console.log err  
    else
      # Do nothing

  # This is quite stupid but lets go with it for now...
  # Set document view position to absolute so it can be scrolled if its long one
  # Position is fixed by default so we get the right top value after @$el is rendered
  setViewPosition: ->
    @positionInterval = setInterval =>
      if @$el.position().top isnt 0
        @topPosition = @$el.position().top
        @$el.css
          position: "absolute"
          top: @topPosition
        clearInterval @positionInterval
      else 
        # Wait for it
    ,300


  render: ->
    @$el.html @renderTemplate "document", @.model.toJSON()
    @setViewPosition()

