class Notes.Views.ArticlesIndex extends Backbone.View
  template: JST['articles/index']
  events:
    'submit form#new_article': 'createArticle'
  initialize: ->
    @collection.on('reset',@render,this)
    @collection.on('add',@appendEntry,this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendEntry)
    this

  appendEntry: (article)->
    view = new Notes.Views.Article(model: article)
    $('ul#article_list').append(view.render().el)

  createArticle: (e)->
    e.preventDefault()
    attributes = title: $('#new_article_name').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_article')[0].reset()
      error: @handleError

  handleError: (entry,response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages
