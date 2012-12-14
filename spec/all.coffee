specs = [
  'my_first_spec'
]

require ['domReady'].concat(specs), (domReady)->
  jasmineEnv = jasmine.getEnv();
  jasmineEnv.updateInterval = 200;

  htmlReporter = new jasmine.HtmlReporter()

  jasmineEnv.addReporter(htmlReporter)

  jasmineEnv.specFilter = (spec)-> htmlReporter.specFilter(spec)

  domReady -> jasmineEnv.execute()
