define ['vendor/backbone'], (Backbone)->
  Backbone.Router.extend
    initialize: (app)->
      @app = app

    routes:
      "": "index"
      "view/:slug": "view"

    index: ()->
      @navigate('view/welcome-visitors', {trigger:true, replace:true} )

    view: (slug)->
      @app.resetToSlug(slug)
