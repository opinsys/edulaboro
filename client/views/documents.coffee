views = NS "Edulaboro.views"

class views.Documents extends Edulaboro.View

  className: "all-documents"

  constructor: ->
    super
    @.collection.on "change", =>
      @render()
    @.collection.on "reset", => 
      @render()
    @.model.on "change:mode", =>
      if @.model.get("mode") is "editor" and @.model.get("newDocument") and @.model.get("id") isnt ""
        # @.collection.add
        console.log "Mode changed in documents view"


    @.collection.fetch()

  events: ->
    "click button.js-get-document-btn": "editDocument"

  fetchDoc: ->
    @render()

  editDocument: (event) ->
    # this is bad and it breaks stuff, need to FIX IT
    @.model.set mode:"no_editor"
    @document = @.collection.get(event.currentTarget.id).toJSON()
    @.model.set
      newDocument: false
      documentTitle: @document.value.title
      documentText: @document.value.document
      id: @document.id
      mode: "editor"

  render: ->
    if @.collection.isFetched
      @$el.html @renderTemplate "documents", documents: @.collection.toJSON()
      console.log "Collection: "
      console.log @.collection.toJSON()
    else
      console.log @.collection.isFetched