define ['vendor/backbone'], (Backbone)->
  Pages = Backbone.Collection

  createPageBoard = ({pagesCollection,pageLoader}={})->
    pagesCollection ?= new Pages()


    onInternalLink = (slug)->
      page = pageLoader.loadFromSlug(slug)

    resetToSlug = (slug)->
      page = pageLoader.loadFromSlug(slug)
      pagesCollection.reset( [page] )

    pagesCollection.on( 'link:internal', onInternalLink )


    { pagesCollection, resetToSlug }


  createPageBoard
