window.Notes =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Notes.Routers.Articles()
    Backbone.history.start()

$(document).ready ->
  Notes.initialize()
