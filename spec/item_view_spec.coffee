define ['item_view','vendor/backbone'], (ItemView,Backbone)->
  genericModel = new Backbone.Model()

  describe 'ItemView', ->
    describe 'rendering', ->
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

      it "renders simple internal links correctly", ->
        item = new Backbone.Model
          text: 'I have a [[simple]] link in me'
        itemView = new ItemView( model: item )
        itemView.render()

        $a = itemView.$el.find('a')
        expect( $a ).toExist()
        expect( $a ).toHaveText('simple')
        expect( $a ).toHaveClass('internal')
        expect( $a.data('slug') ).toBe('simple')

      it 'renders multiple internal links', ->
        item = new Backbone.Model
          text: '[[uno]], [[duex]], [[three]]!'
        itemView = new ItemView( model: item )
        itemView.render()

        $a = itemView.$el.find('a.internal')
        expect( $a.size() ).toBe(3)

      it "renders complex internal links correctly", ->
        item = new Backbone.Model
          text: 'well, [[A link with Bangs! and <3]] is complex'
        itemView = new ItemView( model: item )
        itemView.render()

        $a = itemView.$el.find('a.internal')
        expect( $a ).toHaveText('A link with Bangs! and <3')
        expect( $a.data('slug') ).toBe('a-link-with-bangs-and-3')

      describe 'rendering references', ->
        item = itemView = undefined
        beforeEach ->
          item = new Backbone.Model
            type: 'reference'
            slug: 'slug-being-referenced'
            text: 'reference text'
            title: 'Reference title'
            site: 'reference.site.com'
          itemView = new ItemView( model: item )
          itemView.render()

        $linkEl = ->
          itemView.$el.find('a.internal')

        it 'renders the ref title as a link', ->
          expect( itemView.$el ).toContain('a.internal')
          expect( $linkEl() ).toHaveText('Reference title')

        it 'renders the text', ->
         expect( itemView.$el.find('p') ).toHaveText('reference text')

        it 'adds the slug as data', ->
          expect( $linkEl() ).toHaveData('slug','slug-being-referenced')

        it 'adds the site as data', ->
          expect( $linkEl() ).toHaveData('site','reference.site.com')

        it 'renders the flag'

        it 'triggers an event with the relevant info when the ref. link is clicked', ->
          item.internalLinkFollowed = sinon.spy()
          $linkEl().click()
          expect( item.internalLinkFollowed ).toHaveBeenCalledWith
            slug:'slug-being-referenced'
            site: 'reference.site.com'
