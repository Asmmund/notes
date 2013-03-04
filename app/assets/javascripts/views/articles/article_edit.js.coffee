class Notes.Views.ArticleEdit extends Backbone.View
  template: JST['articles/edit']
  events:
    'click a.delete': 'deleteArticle'
    'click div.public': 'hideArticle'
    'click div.private': 'publishArticle'
    'submit form#edit_article': 'saveArticle'
  initialize: (collection,id)->
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
    @model.destroy(wait: true)
    Backbone.history.navigate("/articles",true)
  saveArticle: (e)->
    e.preventDefault()
    attributes =
      title: $('#article_title').val()
      body: $('#article_body').val()
    @model.save attributes,
      wait: true
      success: ->  Backbone.history.navigate("/articles",true)
      error: -> alert 'Error'
    #

  handleError: (entry,response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages


    attributes =
    alert 'save'

