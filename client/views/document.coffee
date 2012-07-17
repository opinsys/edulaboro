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
      @docViewTop = $(window).height() - 700 + $(window).scrollTop() + "px"
      @$el.css 
        top: @docViewTop
    else if @$el.hasClass("display_block")
      @$el.addClass "display_none"
      @$el.removeClass "display_block"
    @render()

    @.model.on "change", =>
      console.log "Document Model changed!"
      if @$el.hasClass("display_none")
        @$el.addClass "display_block"
        @$el.removeClass "display_none"
      else if @$el.hasClass("display_block")
        @$el.addClass "display_none"
        @$el.removeClass "display_block"
  events: ->
    "click button.js-close-document-btn": "closeView"

  closeView: ->
    @$el.remove()

  render: ->
    @$el.html @renderTemplate "document", @.model.toJSON()