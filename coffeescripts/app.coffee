define ['page_view','page_model'], (PageView,PageModel)->
  nullPageView = { remove: -> }

  createApp = ({pageStore,$mainSection,createPageView,createPageModel})->
    createPageView ?= (args...)-> new PageView(args...)
    createPageModel ?= (args...)-> new PageModel(args...)
    rootPageView = nullPageView 

    replaceRootPageView = (newView)->
      rootPageView.remove()
      rootPageView = newView
      $mainSection.append( rootPageView.render().el ) 

    resetToSlug = (slug)->
      pageDefinition = pageStore.lookupPageDefinition(slug)
      page = createPageModel(pageDefinition)
      pageView = createPageView(model:page)
      replaceRootPageView( pageView )

    app = { resetToSlug }

  createApp
