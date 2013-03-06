window.Notes =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Notes.Routers.Articles()
    Backbone.history.start(pushState: true)


$(document).ready ->
  Notes.initialize()
