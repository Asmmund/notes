class Notes.Views.PublicArticle extends Backbone.View
  tagName: 'li'
  template: JST['articles/public_menu']
  events:
    'click a.view_full': 'show'
  initialize: ->
    @model.on('change',@render,this)
  render: ->
    $(@el).html(@template(article: @model))
    this
  show:  (e)->
    e.preventDefault()
    Backbone.history.navigate("public/articles/#{@model.get('id')}",true)

