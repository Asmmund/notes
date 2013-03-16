class Notes.Views.signupView extends Backbone.View
  template: JST['users/signup']
  events:
    'submit form#create_user': 'createUser'
  checkField: (fieldId) ->
    $('#'+fieldId).val() != ''

  inputFilled: ->
    @checkField( 'name' ) && @checkField( 'email' ) && @checkField( 'password' ) && $('#password').val() == $('#password_confirmation').val()
  readAttributes: ->
    atr =
      name: $('#name').val()
      email: $('#email').val()
      password: $('#password').val()
      password_confirmation: $('#password_confirmation').val()
  initialize: ()->
    @model = new Notes.Models.User()
    @model.on('change',@render,this)
  createUser: (e)->
    e.preventDefault()
    unless @inputFilled()
      alert 'All fields must be filled, passwords must match'
      return
    attributes = @readAttributes()
    @model.save attributes,
      wait: true
      success: ->
        alert 'User was created'
        Backbone.history.navigate('',true)
      error: @handleError
  handleError: (entry,response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages
  render: ->
    $(@el).html(@template())
    this
