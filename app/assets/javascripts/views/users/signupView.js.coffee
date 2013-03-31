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
        @$('#errors').html('<span class="correct">User was created, you\'ll be redirected to the main page and you can login</span>' )
        setTimeout('Backbone.history.navigate("login",true);',3000)
      error: @handleError
  handleError: (entry,response) ->
    errors = ''
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        errors += "#{attribute} #{message} <br />" for message in messages
      @$('#errors').html(errors)
  render: ->
    $(@el).html(@template())
    this
