class Notes.Views.PublicArticlesIndex extends Backbone.View
  template: JST['articles/public_index']
  events:
    # 'submit form#new_article': 'createArticle'
    'click #login': 'login'
  initialize: ->
    @collection.on('reset',@render,this)
    @collection.on('add',@appentArticle,this)

  render: ->
    console.log  @currentUser
    $(@el).html(@template())
    @collection.each(@appentArticle)
    this

  appentArticle: (article) =>
    view = new Notes.Views.PublicArticle(model: article)
    @$('ul#article_list').append(view.render().el)

  login: (e)->
    e.preventDefault()
    Backbone.history.navigate("login",true)
  # createArticle: (e)->
  #   e.preventDefault()
  #   attributes =
  #     title: $('#new_article_name').val()
  #     body: 'Text of newly created article'
  #   @collection.create attributes,
  #     wait: true
  #     success: (articles,new_model)->
  #       $('#new_article')[0].reset()
  #       Backbone.history.navigate("articles/edit/#{new_model.id}",true)
  #     error: @handleError

  # handleError: (entry,response) ->
  #   if response.status == 422
  #     errors = $.parseJSON(response.responseText).errors
  #     for attribute, messages of errors
  #       alert "#{attribute} #{message} " for message in messages
