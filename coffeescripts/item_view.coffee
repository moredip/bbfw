define ['vendor/backbone'], (Backbone)->
  asSlug = (name) ->
    name.replace(/\s/g, '-').replace(/[^A-Za-z0-9-]/g, '').toLowerCase()

  renderInternalLink = (match,linkText)->
    """<a class="internal">#{linkText}</a>"""

  convertBracketsToElements = (html)->
    html.replace(/\[\[([^\]]+)\]\]/gi, renderInternalLink)

  htmlizeElementContents = ($el)->
    rawHtml = $el.html()
    $el.html( convertBracketsToElements(rawHtml) )
    $el.find('a').each (i,a)->
      $a = $(a)
      slug = asSlug($a.text())
      $a.data('slug', slug)

      $a.attr('href',"javascript:void(0)")
    $el



  ItemView = Backbone.View.extend
    tagName: 'div'
    className: 'item'

    events: 
      'click a': 'linkClicked'

    renderReferenceElements: ->
      $link = $('<a>')
        .addClass('internal')
        .attr('href','javascript:void(0)')
        .data
          'slug': @model.get('slug')
          'site': @model.get('site')
        .text(@model.get('title'))
      $img = $('<img>')
        .addClass('small-flag')
        .attr('src', "http://#{@model.get('site')}/favicon.png")

      $('<div>').append($img).append($link)
      

    render: ->
      @$el.addClass(@model.get('type'))

      if @model.get('type') == 'reference'
        @$el.append( @renderReferenceElements() )

      $textPara = $('<p>').text(@model.get('text'))
      htmlizeElementContents($textPara)
      $textPara.appendTo(@$el)

      @

    linkClicked: (e)->
      e.preventDefault()
      $target = $(e.target)
      @model.internalLinkFollowed
        slug: $target.data('slug')
        site: $target.data('site')
