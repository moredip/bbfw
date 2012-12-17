define ['app'], (createApp)->
  describe 'app', ->
    fakeMainSection = undefined

    beforeEach ->
      fakeMainSection = 
        append: ->

    describe 'resetToSlug', ->
      it 'should lookup the correct slug from its pageStore', ->
        spyPageStore = 
          lookupPageDefinition: sinon.spy()
          
        app = createApp( {pageStore:spyPageStore, $mainSection:fakeMainSection} )
        app.resetToSlug('some-slug')

        expect( spyPageStore.lookupPageDefinition ).toHaveBeenCalledWith('some-slug' )


