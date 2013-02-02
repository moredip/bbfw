define ['vendor/backbone'], (Backbone)->
  Pages = Backbone.Collection

  createPageBoard = ({pagesCollection,pageLoader}={})->
    pagesCollection ?= new Pages()


    onInternalLink = (linkInfo)->
      pageLoader.loadFromSlug(linkInfo.slug).then (page)->
        pagesCollection.add(page)

    resetToSlug = (slug)->
      pageLoader.loadFromSlug(slug).then (page)->
        pagesCollection.reset( [page] )

    pagesCollection.on( 'link:internal', onInternalLink )


    { pagesCollection, resetToSlug }


  createPageBoard
