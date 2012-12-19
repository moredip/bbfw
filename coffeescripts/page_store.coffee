HARD_CODED_BASE_URL = "http://fed.wiki.org/"

define ['deferred','jquery'], (createDeferred,$)->
  createPageStore = ->
    lookupPageDefinition: (slug)->
      url = "#{HARD_CODED_BASE_URL}#{slug}.json?nonce=#{Date.now()}"
      $.get(url)

  {
    createPageStore
  }
