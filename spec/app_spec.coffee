define ['app'], (createApp)->
  describe 'app', ->
    fakePageStore = undefined
    fakeMainSection = undefined
    fakePageView = undefined
    fakePageModel = undefined

    beforeEach ->
      fakePageStore = 
        lookupPageDefinition: -> 
      fakeMainSection = 
        append: ->
      fakePageView = 
        render: -> @

    createAppWithFakes = ({createPageView,createPageModel}={})->
      createPageView ?= (-> fakePageView)
      createPageModel ?= (-> fakePageModel)

      createApp
        pageStore:fakePageStore
        $mainSection:fakeMainSection
        createPageView: createPageView
        createPageModel: createPageModel

    describe 'resetToSlug', ->
      it 'should lookup the correct slug from its pageStore', ->
        fakePageStore = 
          lookupPageDefinition: sinon.spy()
          
        app = createAppWithFakes()
        app.resetToSlug('some-slug')

        expect( fakePageStore.lookupPageDefinition ).toHaveBeenCalledWith('some-slug' )

      it 'creates a new page view/model pair for the page definition found in the store', ->
        fakePageStore = 
          lookupPageDefinition: -> 'fake page definition'
        createPageModel = sinon.stub().returns('fake page model')
        createPageView = sinon.stub().returns( fakePageView )

        app = createAppWithFakes
          createPageView: createPageView
          createPageModel: createPageModel

        app.resetToSlug('some-slug')

        expect(createPageModel).toHaveBeenCalledWith('fake page definition')
        expect(createPageView).toHaveBeenCalledWith(model:'fake page model')

      it 'renders the page view', ->
        fakePageView = 
          render: sinon.stub().returns(fakePageView)

        app = createAppWithFakes()
        app.resetToSlug('blah')

        expect(fakePageView.render).toHaveBeenCalled()

      it 'appends the rendered page view to the main section', ->
        fakePageView.el = 'fake page view el'
        fakeMainSection = 
          append: sinon.spy()

        app = createAppWithFakes()
        app.resetToSlug('blah')

        expect(fakeMainSection.append).toHaveBeenCalledWith('fake page view el')

      it 'removes clears out previous page views', ->
        firstFakePageView = 
          render: -> @
          remove: sinon.spy()
        secondFakePageView = 
          render: -> @
          remove: sinon.spy()

        app = createAppWithFakes
          createPageView: sinon.stub().returns(firstFakePageView,secondFakePageView)

        app.resetToSlug('blah')

        expect( firstFakePageView.remove ).not.toHaveBeenCalled()
        app.resetToSlug('blah')
        expect( firstFakePageView.remove ).toHaveBeenCalled()
        expect( secondFakePageView.remove ).not.toHaveBeenCalled()

