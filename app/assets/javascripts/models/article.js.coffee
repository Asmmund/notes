class Notes.Models.Article extends Backbone.Model
  validate: (attrs) ->
    if (!attrs.title || !attrs.body)
      return 'Blank data isn\'t allowed.';
  publish: ->
    @set(published: true)
    @save()
  private: ->
    @set(published: false)
    @save()
