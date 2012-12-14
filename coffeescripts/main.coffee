require ['page_view','page_model','page_store'], (PageView,PageModel,PageStore)->
  # HACK, don't know why I can't just require JQuery
  $ = jQuery

  thePageStore = PageStore.createPageStore()

  $ ->
    pageDefinition = thePageStore.lookupPageDefinition('welcome-visitors')
    page = new PageModel(pageDefinition)
    pageView = new PageView( model: page )

    $('section.main').append( pageView.render().el ) 
