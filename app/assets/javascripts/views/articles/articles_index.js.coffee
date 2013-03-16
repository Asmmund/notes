class Notes.Views.ArticlesIndex extends Backbone.View
  template: JST['articles/index']
  events:
    'submit form#new_article': 'createArticle'
  initialize: ->
    @collection.on('reset',@render,this)
    @collection.on('add',@appentArticle,this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appentArticle)
    this

  appentArticle: (article) =>
    view = new Notes.Views.Article(model: article)
    @$('ul#article_list').append(view.render().el)

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
    console.log entry, response
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages
