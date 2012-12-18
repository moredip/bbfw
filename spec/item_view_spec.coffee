define ['item_view','vendor/backbone'], (ItemView,Backbone)->
  genericModel = new Backbone.Model()

  describe 'ItemView', ->
    it 'renders as a div.item', ->
      itemView = new ItemView( model: genericModel )
      itemView.render()
      expect( itemView.$el ).toBe('div.item')

    it "adds the item's type as a css class", ->
      item = new Backbone.Model( type: 'the-item-type' )
      itemView = new ItemView( model: item )
      itemView.render()
      expect( itemView.$el ).toHaveClass('the-item-type')

    it "renders the item's text in a <p>", ->
      item = new Backbone.Model( text: 'I <3 federation' )
      itemView = new ItemView( model: item )
      itemView.render()
      expect( itemView.$el ).toHaveHtml('<p>I &lt;3 federation</p>')



