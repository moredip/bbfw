define ['vendor/backbone','item_view'], (Backbone,ItemView)->
  PageView = Backbone.View.extend
    tagName: 'article'
    className: 'page'

    createItemView: (args...)-> new ItemView(args...)

    render: ->
      @$el.html("<h2>#{@model.get('title')}</h2>")
      @model.get('story').each (item)=>
        itemView = @createItemView(model:item)
        @$el.append( itemView.render().$el )
      @
