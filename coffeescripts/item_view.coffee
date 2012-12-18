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

      # TEMPORARY HACK SO WE CAN WATCH LINKS WORK
      $a.attr('href',"#view/#{slug}")
    $el



  ItemView = Backbone.View.extend
    tagName: 'div'
    className: 'item'

    render: ->
      @$el.addClass(@model.get('type'))

      $textPara = $('<p>').text(@model.get('text'))
      htmlizeElementContents($textPara)
      $textPara.appendTo(@$el)

      @

