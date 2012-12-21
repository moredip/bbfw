define ['page_model'], (PageModel)->
  createPageLoader = ({pageStore, createPageModel})->
    createPageModel ?= (args...)-> new PageModel(args...)

    loadFromSlug = (slug)->
      # TODO: handle lookup failure
      pageStore.lookupPageDefinition(slug).pipe (pageDefinition)->
        console.log( 'loaded page', pageDefinition )
        createPageModel(pageDefinition)

    pageLoader = { loadFromSlug }
