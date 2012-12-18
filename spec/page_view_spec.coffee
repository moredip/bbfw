define ['page_view','vendor/backbone'], (PageView,Backbone)->
  pageModel = undefined
  pageView = undefined

  createFakeView = ->
    render: -> @
    $el: $('<div class="fake-view">')

  beforeEach ->
    pageModel = new Backbone.Model
      story: new Backbone.Collection 

  afterEach ->
    pageView.remove() if pageView?

  describe 'PageView', ->
    it 'renders as a article.page', ->
      pageView = new PageView(model:pageModel)
      pageView.render()
      expect( pageView.$el ).toBe('article.page')

    it 'renders the page title in a <h2>', ->
      pageModel = new Backbone.Model
        title: 'the page title <3'
        story: new Backbone.Collection

      pageView = new PageView(model:pageModel)
      pageView.render()

      $h2 = pageView.$el.find('h2')
      expect( $h2 ).toExist()
      expect( $h2 ).toHaveText('the page title <3')

    it "creates an item view for each item in the page's story", ->
      pageModel = new Backbone.Model
        story: new Backbone.Collection( [1,2,3] )

      pageView = new PageView(model:pageModel)
      pageView.createItemView = createFakeView

      pageView.render()

      expect( pageView.$el.find('div.fake-view').size() ).toBe(3)
