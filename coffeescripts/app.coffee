createPageStore = ->
  lookupPageDefinition: (slug)->
    {
      title: slug
      story: [
        {
          type: 'paragraph'
          text: "Hello world. This is the page with slug #{slug}"
        },
        {
          type: 'paragraph'
          text: 'Goodbye for now.'
        }
      ]
    }

thePageStore = createPageStore()

ItemModel = Backbone.Model

StoryCollection = Backbone.Collection.extend
  model: ItemModel

PageModel = Backbone.Model.extend
  initialize: ->
    story = new StoryCollection( @get('story') ) 
    @set('story', story)


ItemView = Backbone.View.extend
  tagName: 'div'
  className: 'item'

  render: ->
    @$el
      .addClass(@model.get('type'))
      .html("<p>#{@model.get('text')}</p>")
    @

PageView = Backbone.View.extend
  tagName: 'article'
  className: 'page'

  render: ->
    @$el.html("<h2>#{@model.get('title')}</h2>")
    container = @el
    @model.get('story').each (item)->
      itemView = new ItemView(model:item)
      itemView.render().$el.appendTo(container) 
    @
  

$ ->
  pageDefinition = thePageStore.lookupPageDefinition('welcome-visitors')
  page = new PageModel(pageDefinition)
  pageView = new PageView( model: page )

  $('section.main').append( pageView.render().el ) 
