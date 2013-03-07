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
    el_id = "article_body" + @model.get("id")
    if tinyMCE.getInstanceById(el_id)
      tinyMCE.execCommand 'mceFocus', false, el_id
      tinyMCE.execCommand "mceRemoveControl", false, el_id
    tinyMCE.execCommand "mceAddControl", false, el_id
    tinyMCE.triggerSave();

  show: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.ArticleShow(model: @model)
    $('#container').html(view.render().el)
  index: ->
    view = new Notes.Views.ArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)