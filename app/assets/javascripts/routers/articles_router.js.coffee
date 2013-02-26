class Notes.Routers.Articles extends Backbone.Router
  routes:
    '': 'index'
    'articles/:id': 'show'
  initialize: ->
    @collection = new Notes.Collections.Articles()
    @collection.fetch()
  show: (id)->
    alert "article #{id}"
  index: ->
    view = new Notes.Views.ArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)