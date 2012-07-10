Edulaboro = NS "Edulaboro"

class Edulaboro.View extends Backbone.View

  renderTemplate: (templateName, context) ->
    source = $("#template-"+templateName).html()
    template = Handlebars.compile(source)
    template(context)

