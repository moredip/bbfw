require ['vendor/backbone','page_store','router','app'], (Backbone,PageStore,AppRouter,createApp)->
  # HACK, don't know why I can't just require JQuery
  $ = jQuery


  $ ->
    pageStore = PageStore.createPageStore()
    $mainSection = $('section.main')
    theApp = createApp({pageStore,$mainSection})

    router = new AppRouter( theApp )
    Backbone.history.start()
