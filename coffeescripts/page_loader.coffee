define ->
  createPageLoader = ({pageStore, createPageModel})->
    loadFromSlug = (slug)->
      pageDefinition = pageStore.lookupPageDefinition(slug)
      # TODO: handle lookup failure
      createPageModel(pageDefinition)

     { loadFromSlug }

  createPageLoader
