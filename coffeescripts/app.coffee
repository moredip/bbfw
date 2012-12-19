define ['pages_view','page_loader','page_board'], (PagesView,createPageLoader,createPageBoard)->

  createApp = ({pageStore,$mainSection})->
    pageLoader = createPageLoader({pageStore})
    pageBoard = createPageBoard({pageLoader})
    pagesView = new PagesView
      el: $mainSection
      collection: pageBoard.pagesCollection

    pagesView.render()

    resetToSlug = pageBoard.resetToSlug
    app = { resetToSlug }

  createApp
