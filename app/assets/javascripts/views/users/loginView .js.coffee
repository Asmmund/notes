class Notes.Views.loginView extends Backbone.View
  template: JST['users/login']
  events:
    'submit form#login_user': 'authorize'

  loginUser: (e)->
    e.preventDefault()
    if !@validateField('password') && !@validateField('email')
      return false
    attributes = @readAttributes()
    console.log attributes

   authorize: (e)->
    @bindParams()
    e.preventDefault()
    if @submitButton.hasClass("disabled") and (@form.data("user-authorized") isnt true)
      return false
    else
      @submitButton.addClass "disabled"
    self = this
    attrs = readAttributes()

    User.authorize attrs, (err, user) ->
      if err
        @loginFailure()
      else
        @loginSuccess()

    @form.data("user-authorized") is true
  bindParams: ->
    @form = $("form")
    @emailField = @$el.find("input[id=email]")
    @passwordField = $("#password")
    @submitButton = $("input[type=submit]")

  loginSuccess: ->
    @form.data "user-authorized", true
    @form.submit()

  initialize: ->


  readAttributes: ->
    attr =
      email: $('#email').val()
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
