define ['vendor/backbone'], (Backbone)->
  Backbone.Router.extend
    initialize: (app)->
      @app = app

    routes:
      "view/:slug": "view"

    view: (slug)->
      @app.resetToSlug(slug)
