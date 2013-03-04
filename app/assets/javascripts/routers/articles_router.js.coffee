class Notes.Routers.Articles extends Backbone.Router
  routes:
    '': 'index'
    'articles': 'index'
    'articles/:id': "show"
    'articles/edit/:id': 'edit'

  initialize: ->
    @collection = new Notes.Collections.Articles()
    @collection.reset( $('#container').data('articles') )
  edit: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.ArticleEdit(model: @model)
    $('#container').html(view.render().el)
  show: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.ArticleShow(model: @model)
    $('#container').html(view.render().el)
  index: ->
    view = new Notes.Views.ArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)