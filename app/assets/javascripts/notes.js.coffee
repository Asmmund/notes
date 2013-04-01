window.Notes =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Notes.Routers.Articles()
    Backbone.history.start(pushState: true)


$(document).ready ->
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
  Notes.initialize()
