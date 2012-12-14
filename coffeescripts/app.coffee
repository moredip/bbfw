createPageStore = ->
  lookupPageDefinition: (slug)->
    {
      title: slug
      story: [
        {
          type: 'paragraph'
          text: "Hello world. This is the page with slug #{slug}"
        }
      ]
    }

thePageStore = createPageStore()


PageModel = Backbone.Model

PageView = Backbone.View.extend
  tagName: 'article'
  className: 'page'

  render: ->
    @$el.html("<h2>#{@model.get('title')}</h2>")
    @
  

$ ->
  pageDefinition = thePageStore.lookupPageDefinition('welcome-visitors')
  page = new PageModel(pageDefinition)
  pageView = new PageView( model: page )

  $('section.main').append( pageView.render().el ) 
