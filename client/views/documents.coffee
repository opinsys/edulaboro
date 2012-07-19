views = NS "Edulaboro.views"

class views.Documents extends Edulaboro.View

  className: "all-documents"

  constructor: ->
    super
    @.collection.on "change", =>
      console.log "Collection changed"
      # @.collection.fetch()
      @render()
    
    @.collection.on "reset", => 
      @render()

    # There's sometimes a bug with this when you add more than one new document: 
    # -> all added documents after 1st one won't render automatically but they are going to db correctly
    @.collection.on "add", =>
      console.log "New model added!"
      # We need to fetch to get the id of the new document (it would be better to get only that one new document from the db, yes...)
      @.collection.fetch()
      @render()

    @.collection.on "destroy", =>
      @render() 

    @.collection.fetch()

    @.options.helpermodel.on "change:closeAllOtherViews", => 
      console.log "closeAllOtherViews Changed to: " + @.options.helpermodel.get("closeAllOtherViews")

    @.options.helpermodel.on "change:viewRemoved", =>
      console.log "@.options.helpermodel viewRemoved changed to: "+ @.options.helpermodel.get("viewRemoved")
      # Enable the disabled buttons when closing document or eritor view
      if @.options.helpermodel.get("viewRemoved") and @.options.helpermodel.get("id") isnt ""
        @modelButtons = @$("#"+@.options.helpermodel.get("id")+"").children("button")
        @modelButtons.each (i, element) =>
          @$(element).removeAttr "disabled"
        # If we want to enable all the buttons when closing document or eritor view
        # @$('button[class*="js-"]').each (i, element) =>
        #   @$(element).removeAttr "disabled"
        @.options.helpermodel.set 
          id: ""
          viewRemoved: false

  events: ->
    "click button.js-edit-document-btn": "editDocument"
    "click button.js-view-document-btn": "viewDocument"
    "click button.js-remove-document-btn": "removeDocument"

  editDocument: (event) ->
    # Close all other views before opening new one
    @.options.helpermodel.set
      closeAllOtherViews: true
    
    @modelID = @getCurrentModelID(event)
    
    @modelButtons = @$("#"+@modelID+"").children("button")
    @modelButtons.each (i, element) =>
      @$(element).attr "disabled", "disabled"
    
    @.model.set 
      mode:"no_editor"
    
    @document = @getCurrentModel(@modelID).toJSON()
    console.log "closeAllOtherViews: " + @.options.helpermodel.get("closeAllOtherViews")
    
    @.model.set
      documentTitle: @document.value.title
      documentText: @document.value.document
      id: @document.id
      mode: "editor"

  viewDocument: (event) ->
    # Close all other views before opening new one
    @.options.helpermodel.set
      closeAllOtherViews: true
    # Disable the view related buttons when opening a Document view
    @modelID = @getCurrentModelID(event)
    @modelButtons = @$("#"+@modelID+"").children("button")
    @modelButtons.each (i, element) =>
      @$(element).attr "disabled", "disabled"
    # If we want to disable all the buttons when viewing or editing a document
    # @$('button[class*="js-"]').each (i, element) =>
    #   @$(element).attr "disabled", "disabled"
    
    @document = @getCurrentModel(@modelID)
    @documentView = new views.Document
      model: @document
      editorModel: @.model
      helpermodel: @.options.helpermodel
    $("body").append @documentView.el

  removeDocument: (event) ->
    @modelID = @getCurrentModelID(event)
    console.log "Delete document with id: "+ @modelID
    @document = @getCurrentModel(@modelID)

    # For now lets do model destroy confirmation just with confirm (it's ugly and wrong, yes...)
    if confirm "Delete document with title: "+ @document.toJSON().value.title + " \nID: "+ @modelID
      @document.destroy
        headers:
          revision: @document.toJSON().value.revision
        success: (msg) ->
          console.log "Document destroyed: "
          console.log msg
        error: (err) ->
          console.log "Document destroy error: "
          console.log err  
    else
      # Do nothing

  getCurrentModel: (modelID) ->
    return @.collection.get(modelID)

  getCurrentModelID: (event) ->
    return event.currentTarget.dataset.modelId

  render: ->
    if @.collection.isFetched
      @$el.html @renderTemplate "documents", documents: @.collection.toJSON()
      console.log "Collection: "
      console.log @.collection.toJSON()
    else
      console.log @.collection.isFetched