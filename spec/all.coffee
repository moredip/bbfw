specs = [
  'my_first_spec'
]

require ['domReady'].concat(specs), (domReady)->
  jasmineEnv = jasmine.getEnv();
  jasmineEnv.updateInterval = 200;

  htmlReporter = new jasmine.HtmlReporter()
  consoleReporter = new jasmine.ConsoleReporter()

  jasmineEnv.addReporter(htmlReporter)
  jasmineEnv.addReporter(consoleReporter)

  jasmineEnv.specFilter = (spec)-> htmlReporter.specFilter(spec)

  domReady -> jasmineEnv.execute()
