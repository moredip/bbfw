define ['page_board','deferred','vendor/backbone'], (createPageBoard,createDeferred,Backbone)->
  preResolvedPromise = (value)->
    createDeferred().resolve(value).promise()

  describe 'PageBoard', ->
    createFakePageLoader = (fakePage='blah')->
      stubLoadFn = sinon.stub().returns( preResolvedPromise(fakePage) )
      { loadFromSlug: stubLoadFn, loadFromLinkInfo: stubLoadFn }

    describe 'resetToSlug', ->
      it 'loads the page for the given slug', ->
        fakePageLoader = createFakePageLoader()
        pageBoard = createPageBoard(pageLoader:fakePageLoader)

        pageBoard.resetToSlug('some-slug')

        expect( fakePageLoader.loadFromSlug ).toHaveBeenCalledWith('some-slug')

      it 'replaces the page collection contents with the page', ->
        fakePageLoader = createFakePageLoader('fake page')
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
          fakePageLoader = createFakePageLoader()
          pageBoard = createPageBoard(pageLoader:fakePageLoader)

          pageBoard.pagesCollection.trigger( 'link:internal', 'fake link info' )
          expect( fakePageLoader.loadFromLinkInfo ).toHaveBeenCalledWith('fake link info')

        it 'adds a page to the page collection', ->
          fakePageLoader = createFakePageLoader('fake page')
          fakePagesCollection = _.extend Backbone.Events,
            add: sinon.spy()

          pageBoard = createPageBoard
            pageLoader: fakePageLoader
            pagesCollection: fakePagesCollection

          fakePagesCollection.trigger('link:internal', {})

          expect( fakePagesCollection.add ).toHaveBeenCalledWith('fake page')
    


