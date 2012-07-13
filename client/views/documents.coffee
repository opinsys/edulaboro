views = NS "Edulaboro.views"

class views.Documents extends Edulaboro.View

  className: "all-documents"

  constructor: ->
    super
    this.collection.on "change", => @render()
    this.collection.fetch()

  render: ->
    @$el.html @renderTemplate "documents", @collection.toJSON()