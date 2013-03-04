class Notes.Views.ArticleShow extends Backbone.View
  template: JST['articles/show']
  events:
    'click a.delete': 'deleteArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
  initialize: (collection,id)->
    @model.on('change',@render,this)
    @model.on('destroy',@remove,this)
  render: ->
    $(@el).html(@template(article: @model))
    this
  publishArticle: ->
    @model.publish()
  hideArticle: ->
    @model.private()
  deleteArticle: (event)->
    event.preventDefault()
    @model.destroy()
    # @$(el).remove()

