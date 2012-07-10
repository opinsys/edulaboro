views = NS "Edulaboro.views"

class views.WysihtmlForm extends Edulaboro.View

  constructor: ->
    super

  render: ->
    @$el.html @renderTemplate "wysihtml5-form"


class views.WysihtmlToolbar extends Edulaboro.View

  constructor: ->
    super

  render: ->
    @$el.html @renderTemplate "wysihtml5-toolbar"