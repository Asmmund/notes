class Notes.Views.Article extends Backbone.View
  tagName: 'li'
  template: JST['articles/show']
  render: ->
    $(@el).html(@template(article: @model))
    this
