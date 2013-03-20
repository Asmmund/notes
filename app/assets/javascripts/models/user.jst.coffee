class Notes.Models.User extends Backbone.Model
  url: '/api/account'


  authorize: =>
    _this = @
    jQuery.ajax(
      type: 'POST'
      url: '/api/sessions.json'
      wait: true
      data:
        email: @get('email')
        password:  @get('password')
    ).success( (response) ->
      $('form')[0].reset()
      alert( 'Logged in' )
      @currentUser = response
      _this.attributes = response
      Backbone.history.navigate("articles",true)
    ).error( (response) ->
       alert( 'Wrong username or email!' )
       $('#email').focus().select()
    )

  logout: =>

    jQuery.ajax(
      type: 'GET'
      url: '/logout'
      wait: true
    ).success( (response) ->
      alert( response.text )
      return true
    ).error( (response) ->
       alert response.text
       return false
    )
