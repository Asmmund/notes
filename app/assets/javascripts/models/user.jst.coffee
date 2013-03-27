class Notes.Models.User extends Backbone.Model
  url: '/api/account'


  authorize: ->
    obj = {}
    result = true
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
            # $('form')[0].reset()
      window.ajax_status = true
    ).error( (response) ->
      $('#email').focus().select()
      window.ajax_status = false
    )

    return window.ajax_status
    #
  logout: =>

    jQuery.ajax(
      type: 'GET'
      url: '/logout'
      wait: true
    ).success( (response) ->
      alert( response.text )
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
       alert response.text
       return false
    )
