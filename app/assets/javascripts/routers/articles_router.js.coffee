class Notes.Routers.Articles extends Backbone.Router
  currentUser: null
  routes:
    '': 'public_index'
    'public/articles': 'public_index'
    'public/articles/:id': 'public_show'
    'articles': 'index'
    'articles/:id': "show"
    'articles/edit/:id': 'edit'
    'signup': 'signup'
    'login': 'login'

  login: ->
    view = new Notes.Views.loginView()
    $('#container').html(view.render().el)

  signup: ->
    view = new Notes.Views.signupView()
    $('#container').html(view.render().el)

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
    tinyMCE.triggerSave()

  show: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.ArticleShow(model: @model)
    $('#container').html(view.render().el)
  public_show: (id)->
    @model = @collection.get(id)
    view = new Notes.Views.PublicArticleShow(model: @model)
    $('#container').html(view.render().el)

  index: ->
    view = new Notes.Views.ArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)

  public_index: ->
    view = new Notes.Views.PublicArticlesIndex(collection: @collection)
    $('#container').html(view.render().el)