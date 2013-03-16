class Notes.Views.ArticleShow extends Backbone.View
  template: JST['articles/show']
  events:
    'click a.delete': 'deleteArticle'
    'click a.list': 'listArticles'
    'click a.edit': 'editArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
  initialize: ->
    @model.on('change',@render,this)
    @model.on('destroy',@remove,this)
  listArticles: (event)->
    event.preventDefault()
    Backbone.history.navigate("articles",true)
  editArticle: (event)->
    event.preventDefault()
    Backbone.history.navigate("articles/edit/#{@model.get('id')}",true)

  deleteArticle: (event)->
    event.preventDefault()
    if confirm 'Delete this article?'
      @model.destroy(wait: true)
      Backbone.history.navigate("articles",true)
  render: ->
    $(@el).html(@template(article: @model))
    this
  publishArticle: ->
    @model.publish()
  hideArticle: ->
    @model.private()


