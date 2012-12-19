define ['vendor/backbone','page_view'], (Backbone,PageView)->
  PagesView = Backbone.View.extend
    createPageView: (args...)-> new PageView(args...)

    initialize: -> 
      if @collection?
        @collection.on( 'add', @render, @ )
        @collection.on( 'reset', @render, @ )

    render: ->
      @$el.empty()
      @collection.each (page) =>
        pageView = @createPageView(model:page)
        @$el.append( pageView.render().$el )
      @
