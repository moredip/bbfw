define ['page_model'], (PageModel)->
  createPageLoader = ({pageStore, createPageModel})->
    createPageModel ?= (args...)-> new PageModel(args...)

    loadFromLinkInfo = ({slug,site})->
      # TODO: handle lookup failure
      console.log( "loading #{slug} from #{site}" )
      pageStore.lookupPageDefinition(slug,site).pipe (pageDefinition)->
        console.log( 'loaded page', pageDefinition )
        createPageModel(pageDefinition)

    loadFromSlug = (slug)->
      loadFromLinkInfo(slug:slug)

    pageLoader = { loadFromSlug, loadFromLinkInfo }
