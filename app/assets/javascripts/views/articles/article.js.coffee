class Notes.Views.Article extends Backbone.View
  tagName: 'li'
  template: JST['articles/menu']
  events:
    'click a.delete': 'deleteArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
    'click a.view_full': 'show'
    'click a.edit':'edit'
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
    if confirm 'Delete this article?'
      @model.destroy()
  edit: (e)->
    e.preventDefault()
    Backbone.history.navigate("articles/edit/#{@model.get('id')}",true)
  show:  (e)->
    e.preventDefault()
    Backbone.history.navigate("articles/#{@model.get('id')}",true)

