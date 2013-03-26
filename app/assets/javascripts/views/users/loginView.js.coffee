class Notes.Views.loginView extends Backbone.View
  template: JST['users/login']
  events:
    'submit form#login_user': 'loginUser'
    'click a#logout': 'logoutUser'

  logoutUser: (e) ->
    e.preventDefault()
    @model.logout()

  loginUser: (e)->
    e.preventDefault()
    if !@validateField('password') && !@validateField('email')
      return false
    @model.attributes  = @readAttributes()
    result = @model.authorize()
    console.warn result.responseText
    $('#errors').text('')
    if result.status != 401
      Backbone.history.navigate("articles",true)
    else
      $('#errors').text('Wrong name/password!')
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
        errors += "#{attribute} #{message}<br /> " for message in messages
      @$('#errors').text(errors)
      return false

  render: ->
    $(@el).html(@template())
    this

  validateField: (id)->
    if( $('#'+id).val() != '' )
      return true
    $('#errors').text(id.toUpperCase()+' can\'t be blank!')
    return false
