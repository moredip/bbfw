HARD_CODED_ORIGIN = "fed.wiki.org"

define ['deferred','jquery'], (createDeferred,$)->
  createPageStore = ->
    lookupPageDefinition: (slug,site)->
      site ?= HARD_CODED_ORIGIN
      url = "http://#{site}/#{slug}.json?cache-buster=#{Date.now()}"
      $.get(url)

  {
    createPageStore
  }
