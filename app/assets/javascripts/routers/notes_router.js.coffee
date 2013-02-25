class Notes.Routers.Notes extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    alert 'Index route'