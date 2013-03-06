class Notes.Views.ArticleEdit extends Backbone.View
  template: JST['articles/edit']
  events:
    'click a.delete': 'deleteArticle'
    'click a.list': 'listArticles'
    'click a.view': 'viewArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
    'submit form#edit_article': 'saveArticle'
  initialize: ()->
    _.bindAll this,  "render", "afterRender"
    _this = this
    @render = _.wrap(@render, (render) ->
      render()
      _this.afterRender()
      _this
    )
    @model.on('change',@render,this)
    @model.on('destroy',@remove,this)
  afterRender: ->
    console.log tinyMCE
    tinyMCE.execCommand "mceAddControl", true, "article_body" + @model.get("id")

  render: ->
    $(@el).html(@template(article: @model))
    this
  publishArticle: ->
    @model.publish()
  hideArticle: ->
    @model.private()
  listArticles: (e)->
    e.preventDefault()
    Backbone.history.navigate("articles",true)
  viewArticle: (e)->
    e.preventDefault()
    Backbone.history.navigate("articles/#{@model.get('id')}",true)
  deleteArticle: (event)->
    event.preventDefault()
    if confirm 'Delete this article?'
      @model.destroy(wait: true)
      Backbone.history.navigate("articles",true)
  saveArticle: (e)->
    e.preventDefault()
    attributes =
      title: $('#article_title').val()
      body:  tinyMCE.activeEditor.getContent({format : 'raw'})
    @model.save attributes,
      wait: true
      success: ->  Backbone.history.navigate("articles",true)
      error: -> alert 'Error'


