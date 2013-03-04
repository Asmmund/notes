class Notes.Routers.Articles extends Backbone.Router
  routes:
    '': 'index'
    'articles/:id': 'show'
  initialize: ->
    @collection = new Notes.Collections.Articles()
    @collection.reset( $('#container').data('articles') )
  show: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.ArticleShow(model: @model)
    $('#container').html(view.render().el)
  index: ->
    view = new Notes.Views.ArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)