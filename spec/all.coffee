spec_paths = ("spec/#{spec_name}" for spec_name in window.SPEC_LIST)

require ['domReady'].concat(spec_paths), (domReady)->
  jasmineEnv = jasmine.getEnv();
  jasmineEnv.updateInterval = 200;

  htmlReporter = new jasmine.HtmlReporter()
  consoleReporter = new jasmine.ConsoleReporter()

  jasmineEnv.addReporter(htmlReporter)
  jasmineEnv.addReporter(consoleReporter)

  jasmineEnv.specFilter = (spec)-> htmlReporter.specFilter(spec)

  domReady -> jasmineEnv.execute()
