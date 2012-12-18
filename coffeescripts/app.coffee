define ['page_view','page_model','page_loader'], (PageView,PageModel,createPageLoader)->
  nullPageView = { remove: -> }

  createApp = ({pageStore,$mainSection,createPageView,createPageModel})->

    createPageView ?= (args...)-> new PageView(args...)
    createPageModel ?= (args...)-> new PageModel(args...)
    rootPageView = nullPageView 

    pageLoader = createPageLoader({pageStore,createPageModel})

    replaceRootPageView = (newView)->
      rootPageView.remove()
      rootPageView = newView
      $mainSection.append( rootPageView.render().el ) 

    resetToSlug = (slug)->
      page = pageLoader.loadFromSlug(slug)
      pageView = createPageView(model:page)
      replaceRootPageView( pageView )

    app = { resetToSlug }

  createApp
