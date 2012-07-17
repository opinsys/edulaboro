views = NS "Edulaboro.views"

class views.Documents extends Edulaboro.View

  className: "all-documents"

  constructor: ->
    super
    @.collection.on "change", =>
      console.log "Collection changed"
      @render()
    @.collection.on "reset", => 
      @render()

    @.collection.on "add", =>
      console.log "New model added!"
      @render()

    @.collection.fetch()

  events: ->
    "click button.js-get-document-btn": "editDocument"
    "click button.js-view-document-btn": "viewDocument"
    "click button.js-remove-document-btn": "removeDocument"

  editDocument: (event) ->
    # This is ugly and need to do prettier
    @buttonId = event.currentTarget.id
    @buttonLocation = @$("#"+@buttonId+"").position()
    @.model.set 
      mode:"no_editor"
      buttonLocation: @buttonLocation
    @document = @getCurrentModel(event).toJSON()
    @.model.set
      documentTitle: @document.value.title
      documentText: @document.value.document
      id: @document.id
      mode: "editor"

  viewDocument: (event) ->
    @document = @getCurrentModel(event)
    @documentView = new views.Document
      model: @document
    $("body").append @documentView.el
    # @$(".js-view-document-btn").attr "disabled", "disabled"

  removeDocument: (event) ->
    console.log "Remove document with id: "+ event.currentTarget.id
    if confirm "Remove document with id: "+ event.currentTarget.id
      alert "DESTROY!"
    else
      alert "NÄÄH"

  getCurrentModel: (event) ->
    @buttonId = event.currentTarget.id
    return @.collection.get(@buttonId)

  render: ->
    if @.collection.isFetched
      @$el.html @renderTemplate "documents", documents: @.collection.toJSON()
      console.log "Collection: "
      console.log @.collection.toJSON()
    else
      console.log @.collection.isFetched