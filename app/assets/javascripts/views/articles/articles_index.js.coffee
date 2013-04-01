class Notes.Views.ArticlesIndex extends Backbone.View
  template: JST['articles/index']
  events:
    'submit form#new_article': 'createArticle'
    'click #logout': 'logout'
    'click a.public': 'publicWall'
  initialize: ->
    @collection.on('reset',@render,this)
    @collection.on('add',@appentArticle,this)
    @user = new Notes.Models.User()

  render: ->
    console.warn 'Current user:'
    console.warn window.current_user

    $(@el).html(@template())
    @collection.each(@appentArticle)
    this

  appentArticle: (article) =>
    view = new Notes.Views.Article(model: article)
    @$('ul#article_list').append(view.render().el)

  publicWall: (e)->
    e.preventDefault()
    Backbone.history.navigate("public/articles",true)

  # logout: (e)->
  #   e.preventDefault()
  #   @user.logout()
  #   $('#container').data('articles','')
  #   window.location = '/public/articles'
  createArticle: (e)->
    e.preventDefault()
    attributes =
      title: $('#new_article_name').val()
      body: 'Text of newly created article'
    @collection.create attributes,
      wait: true
      success: (articles,new_model)->
        $('#new_article')[0].reset()
        Backbone.history.navigate("articles/edit/#{new_model.id}",true)
      error: @handleError

  handleError: (entry,response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages
