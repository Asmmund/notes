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
    Backbone.history.navigate("articles",true) if @model.authorize()

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
