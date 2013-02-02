define ['page_model'], (PageModel)->
  describe 'PageModel', ->

    it 'creates a story collection', ->
      page = new PageModel
        story: [ {a:10}, {a:20},{a:30} ]

      storyFromPage = page.get('story')

      expect( storyFromPage.each ).toBeDefined()
      expect( (typeof storyFromPage.each) ).toBe('function')
      expect( storyFromPage.size() ).toBe(3)
      expect( storyFromPage.at(1).get('a') ).toBe(20)

    it "publishes the appropriate events when a story item's internal link is followed", ->
      page = new PageModel
        story: [ {a:10}, {a:20},{a:30} ]
      itemInPage = page.get('story').at(0)

      page.on 'link', linkSpy = sinon.spy()
      page.on 'link:internal', internalLinkSpy = sinon.spy()

      linkInfo = 'some link info'
      itemInPage.internalLinkFollowed(linkInfo)

      expect( linkSpy ).toHaveBeenCalledWith(linkInfo)
      expect( internalLinkSpy ).toHaveBeenCalledWith(linkInfo)

