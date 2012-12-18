define ['vendor/backbone'], (Backbone)->
  ItemModel = Backbone.Model.extend
    internalLinkFollowed: (slug)->
      @trigger( 'link', slug: slug, linkType: 'internal' )

  StoryCollection = Backbone.Collection.extend
    model: ItemModel

  PageModel = Backbone.Model.extend
    initialize: ->
      story = new StoryCollection( @get('story') ) 
      @set('story', story)

      # reference cycle?
      story.on('link',@onLink,@)

    onLink: ({slug,linkType})->
      @trigger('link',slug)
      @trigger("link:#{linkType}",slug) if linkType?
