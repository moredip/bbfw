define ->
  createPageStore = ->
    lookupPageDefinition: (slug)->
      {
        title: slug
        story: [
          {
            type: 'paragraph'
            text: "Hello world. This is the page with slug #{slug}"
          },
          {
            type: 'paragraph'
            text: 'Goodbye for now.'
          }
        ]
      }

  {
    createPageStore
  }
