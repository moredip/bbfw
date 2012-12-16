define ['page_view','page_model'], (PageView,PageModel)->
  nullPageView = { remove: -> }

  createApp = ({pageStore,$mainSection})->
    rootPageView = nullPageView 

    replaceRootPageView = (newView)->
      rootPageView.remove()
      rootPageView = newView
      $mainSection.append( rootPageView.render().el ) 

    resetToSlug = (slug)->
      pageDefinition = pageStore.lookupPageDefinition(slug)
      page = new PageModel(pageDefinition)
      pageView = new PageView( model: page )
      replaceRootPageView( pageView )

    app = { resetToSlug }

  createApp
