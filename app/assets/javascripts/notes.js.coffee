window.Notes =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Notes.Routers.Notes()
    Backbone.history.start()

$(document).ready ->
  Notes.initialize()
