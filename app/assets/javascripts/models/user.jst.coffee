class Notes.Models.User extends Backbone.Model
  url: '/api/account'


  authorize: ->
    ret = false
    jQuery.ajax(
      type: 'POST'
      url: '/api/sessions.json'
      wait: true
      data:
        email: @get('email')
        password:  @get('password')
    ).success( (response) ->
      ret = true
    ).error( (response) ->
      ret = false
    )
    ret





