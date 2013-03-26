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
      @currentUser = response
      _this.attributes = response
      return response
    ).error( (response) ->
      return false
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
