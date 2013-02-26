class Notes.Views.ArticlesIndex extends Backbone.View

  template: JST['articles/index']
  initialize: ->
    @collection.on('reset',@render,this)
  render: ->
    $(@el).html(@template(articles: @collection))
    this
