class Notes.Models.Article extends Backbone.Model

  publish: ->
    @set(published: true)
    @save()
  private: ->
    @set(published: false)
    @save()
