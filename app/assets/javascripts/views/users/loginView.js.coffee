class Notes.Views.loginView extends Backbone.View
  template: JST['users/login']
  events:
    'submit form#login_user': 'loginUser'
    'click #signup': 'signup'
  signup: (e)->
    e.preventDefault()
    Backbone.history.navigate("signup",true)
  loginUser: (e)->
    e.preventDefault()
    if !@validateField('password') && !@validateField('email')
      return false
    attr = @readAttributes()
    @model.attributes  = attr
    @$('#errors').text()
    # TODO Solve error with login from 2 submit
    result = @model.authorize()
    console.warn 'view:'
    console.warn result
    if ( result.email != '' )
      @$('form')[0].reset()
      @$('#errors').html('<span class="correct">You\'ll be redirected to your articles '+ window.current_user.name+'</span>' )
      setTimeout('window.location = "articles";',1000)
    else
      @$('#email').focus().select()
      @$('#errors').text('Wrong email/password!')




  bindParams: ->
    @form = @$("form")
    @emailField = @$("#email")
    @passwordField = @$("#password")
    @submitButton = @$("input[type=submit]")


  initialize: ->
    @bindParams()
    @model = new Notes.Models.User()
    # @model.on('authorize',@authorize,this)
  readAttributes: ->
    attr =
      email: @$('#email').val()
      password: @$('#password').val()


  handleError: (entry,response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message} " for message in messages
  render: ->
    $(@el).html(@template())
    this

  validateField: (id)->
    if( $('#'+id).val() != '' )
      return true
    alert('field '+ id.toUpperCase()+' can\'t be blank!')
    return false
