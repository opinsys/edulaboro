views = NS "Edulaboro.views"

class views.WysihtmlEditor extends Edulaboro.View

  className: "new-document-container display_none"

  constructor: ->
    super
    this.model.on "change", =>
      if this.model.get("mode") is "no_editor"
        @$el.addClass "display_none"
        @$el.removeClass "display_block"
      else
        @$el.addClass "display_block"
        @$el.removeClass "display_none"

  events: ->
    "click a.js-cancel-document-button": "cancelDocument"
    "click a.js-save-document-button": "saveDocument"

  cancelDocument: ->
    if this.model.get("mode") is "editor"
      this.model.set mode: "no_editor"

  saveDocument: ->
    alert @$("#js-wysihtml5-textarea").val()

  render: ->
    @$el.html @renderTemplate "wysihtml5-editor"