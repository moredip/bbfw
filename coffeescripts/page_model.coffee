define ['vendor/backbone'], (Backbone)->
  ItemModel = Backbone.Model

  StoryCollection = Backbone.Collection.extend
    model: ItemModel

  PageModel = Backbone.Model.extend
    initialize: ->
      story = new StoryCollection( @get('story') ) 
      @set('story', story)

