require ['jquery','vendor/backbone','page_store','router','app'], ($,Backbone,PageStore,AppRouter,createApp)->
  $ ->
    pageStore = PageStore.createPageStore()
    $mainSection = $('section.main')
    theApp = createApp({pageStore,$mainSection})

    router = new AppRouter( theApp )
    Backbone.history.start()
