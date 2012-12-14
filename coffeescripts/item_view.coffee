define ['vendor/backbone'], (Backbone)->
  ItemView = Backbone.View.extend
    tagName: 'div'
    className: 'item'

    render: ->
      @$el
        .addClass(@model.get('type'))
        .html("<p>#{@model.get('text')}</p>")
      @

