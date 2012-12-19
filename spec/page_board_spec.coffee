define ['page_board','vendor/backbone'], (createPageBoard,Backbone)->
  describe 'PageBoard', ->
    describe 'resetToSlug', ->
      it 'loads the page for the given slug', ->
        fakePageLoader = { loadFromSlug: sinon.spy() }
        pageBoard = createPageBoard(pageLoader:fakePageLoader)

        pageBoard.resetToSlug('some-slug')

        expect( fakePageLoader.loadFromSlug ).toHaveBeenCalledWith('some-slug')

      it 'replaces the page collection contents with the page', ->
        fakePageLoader = { loadFromSlug: -> 'fake page' }
        fakePageCollection = {
          reset: sinon.spy()
          on: ->
        }

        pageBoard = createPageBoard
          pageLoader: fakePageLoader
          pagesCollection: fakePageCollection

        pageBoard.resetToSlug('blah')

        expect( fakePageCollection.reset ).toHaveBeenCalledWith(['fake page'])

      describe 'handling an internal link being followed', ->

        it 'loads the relevant page from the store', ->
          fakePageLoader = { loadFromSlug: sinon.spy() }
          pageBoard = createPageBoard(pageLoader:fakePageLoader)

          pageBoard.pagesCollection.trigger( 'link:internal', 'some-slug' )
          expect( fakePageLoader.loadFromSlug ).toHaveBeenCalledWith('some-slug')

        it 'adds a page to the page collection', ->
          fakePageLoader = { loadFromSlug: -> 'fake page' }
          fakePagesCollection = _.extend Backbone.Events,
            add: sinon.spy()

          pageBoard = createPageBoard
            pageLoader: fakePageLoader
            pagesCollection: fakePagesCollection

          fakePagesCollection.trigger('link:internal')

          expect( fakePagesCollection.add ).toHaveBeenCalledWith('fake page')
    


