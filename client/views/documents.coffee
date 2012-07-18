views = NS "Edulaboro.views"

class views.Documents extends Edulaboro.View

  className: "all-documents"

  constructor: ->
    super
    @.collection.on "change", =>
      console.log "Collection changed"
      @.collection.fetch()
      @render()
    
    @.collection.on "reset", => 
      @render()

    @.collection.on "add", =>
      console.log "New model added!"
      @.collection.fetch()
      @render()

    @.collection.fetch()

    @.options.helpermodel.on "change:viewRemoved", =>
      console.log "@.options.helpermodel changed!"
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
    @modelID = @getCurrentModelID(event)
    
    @modelButtons = @$("#"+@modelID+"").children("button")
    @modelButtons.each (i, element) =>
      @$(element).attr "disabled", "disabled"
    
    @.model.set 
      mode:"no_editor"
    
    @document = @getCurrentModel(@modelID).toJSON()
    
    @.model.set
      documentTitle: @document.value.title
      documentText: @document.value.document
      id: @document.id
      mode: "editor"

  viewDocument: (event) ->
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
    @modelID = @$(".js-model-id-container").attr "id"
    console.log "Remove document with id: "+ event.currentTarget.id
    if confirm "Remove document with id: "+ event.currentTarget.id
      alert "DESTROY!"
    else
      alert "NÄÄH"

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