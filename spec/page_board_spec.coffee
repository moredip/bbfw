define ['page_board'], (createPageBoard)->
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




      xit 'reacts to an internal link being followed by loading that page', ->
        fakePageLoader = sinon.spy()
        pageBoard = createPageBoard(pageLoader:fakePageLoader)

        pageBoard.get('pages').trigger( 'link:internal', 'some-slug' )
        expect( fakePageLoader ).toHaveBeenCalledWith('some-slug')

      xit 'adds the loaded page to the pages'
