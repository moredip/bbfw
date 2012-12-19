define ['vendor/backbone','pages_view'], (Backbone,PagesView)->
  createFakeView = ->
    render: -> @
    $el: $('<div class="fake-view">')

  describe 'PagesView', ->
    it 'registers for events on the collection', ->
      fakeCollection =
        on: sinon.spy()

      new PagesView({
        collection: fakeCollection
      })
        

      expect( fakeCollection.on ).toHaveBeenCalledWith('add')
      expect( fakeCollection.on ).toHaveBeenCalledWith('reset')

    describe 'after a collection reset', ->

      it 'clears the el', ->
        $el = $('<div><div class="preexisting"/></div>')

        pagesView = new PagesView
          el:$el
          collection: new Backbone.Collection

        expect( $el ).toContain( 'div.preexisting' )
        pagesView.collection.reset()
        expect( $el ).not.toContain( 'div.preexisting' )

      it 'creates a page view for each page in the collection', ->
        pagesView = new PagesView
          collection: new Backbone.Collection()
        pagesView.createPageView = createFakeView

        pagesView.collection.reset([1,2,3])

        expect( pagesView.$el.find('div.fake-view').size() ).toBe(3)

    describe 'after a collection add', ->
      it 'ends up with all the pages in the collection rendered', ->
        pagesView = new PagesView
          collection: new Backbone.Collection()
        pagesView.createPageView = createFakeView

        pagesView.collection.add(1)
        pagesView.collection.add(2)

        expect( pagesView.$el.find('div.fake-view').size() ).toBe(2)
