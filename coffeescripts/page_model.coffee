define ['vendor/backbone'], (Backbone)->

  ItemModel = Backbone.Model.extend
    internalLinkFollowed: (linkInfo)->
      @trigger( 'link', linkInfo: linkInfo, linkType: 'internal' )

  StoryCollection = Backbone.Collection.extend
    model: ItemModel

  PageModel = Backbone.Model.extend
    initialize: ->
      story = new StoryCollection( @get('story') ) 
      @set('story', story)

      # reference cycle?
      story.on('link',@onLink,@)

    onLink: ({linkInfo,linkType})->
      @trigger('link',linkInfo)
      @trigger("link:#{linkType}",linkInfo) if linkType?
