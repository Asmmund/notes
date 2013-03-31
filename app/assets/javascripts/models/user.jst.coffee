class Notes.Models.User extends Backbone.Model
  url: '/api/account'


  authorize: ->
    jQuery.ajax(
      type: 'POST'
      url: '/api/sessions.json'
      wait: true
      data:
        email: @get('email')
        password:  @get('password')
    ).success( (response) ->
      window.current_user = response
      @currentUser = response
      @attributes = response
      # console.log 'Model:'
      # console.log response
    ).error( (response) ->
      # console.log response
    )
    # console.log 'Model response:'
    # console.log window.current_user
    return window.current_user

  logout: ->

    jQuery.ajax(
      type: 'GET'
      url: '/ajax_logout'
      wait: true
    ).success( (response) ->
      # console.log ( response)
      window.current_user =
        name: ""
        company: ""
        created_at: ""
        email: ""
        facebook: ""
        id: ""
        license_id: ""
        linkedin: ""
        password_digest: ""
        phone: ""
        title: ""
        twitter: ""
        updated_at: ""
        web: ""

      return true
    ).error( (response) ->
       console.log response
       return false
    )
