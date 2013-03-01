class Notes.Views.Article extends Backbone.View
  tagName: 'li'
  template: JST['articles/menu']
  events:
    'click a.delete': 'deleteArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
  initialize: ->
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
