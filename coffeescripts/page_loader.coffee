define ['page_model'], (PageModel)->
  createPageLoader = ({pageStore, createPageModel})->
    createPageModel ?= (args...)-> new PageModel(args...)

    loadFromSlug = (slug)->
      pageDefinition = pageStore.lookupPageDefinition(slug)
      # TODO: handle lookup failure
      createPageModel(pageDefinition)

    pageLoader = { loadFromSlug }
