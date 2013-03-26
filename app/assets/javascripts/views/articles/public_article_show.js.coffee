class Notes.Views.PublicArticleShow extends Backbone.View
  template: JST['articles/public_show']
  events:
    'click a.list': 'listArticles'
  initialize: ->
    @model.on('change',@render,this)
    @model.on('destroy',@remove,this)
  listArticles: (event)->
    event.preventDefault()
    Backbone.history.navigate("public/articles",true)
  render: ->
    $(@el).html(@template(article: @model))
    this


