__file__ = phantom.libraryPath

waitFor = ({testFn,pollInterval,timeout,onTimeout,onSuccess}) ->

  pollInterval ?= 100
  timeout ?= 3000
  onTimeout ?= -> 
  onSuccess ?= -> 

  deadline = new Date().getTime() + timeout
  poll = ->
    if (new Date().getTime() > deadline)
      clearInterval(interval)
      onTimeout()
    else if testFn()
      clearInterval(interval)
      onSuccess()

  interval = setInterval poll, pollInterval

page = require('webpage').create()

page.onConsoleMessage = (msg) ->
  console.log(msg)

page.onError = (msg, trace)->
  console.log('PAGE ERROR',msg,trace)

#page.onResourceRequested = (req)->
  #console.log( 'requesting '+ req.url )

page.startTestRun = ->
  @.evaluate ->
    spec_paths = ("../spec/#{spec_name}" for spec_name in window.SPEC_LIST)
    require ['domReady'].concat(spec_paths), (domReady)->
      jasmineEnv = jasmine.getEnv();
      jasmineEnv.updateInterval = 200;

      reporter = new jasmine.JsApiReporter()

      # hackery
      reporter.reportRunnerResults = ->
        @.finished = true
        window.TEST_RESULTS = @.results_

      window.TEST_RESULTS = undefined

      jasmineEnv.addReporter(reporter)
      jasmineEnv.addReporter( new jasmine.ConsoleReporter() )
      jasmineEnv.execute()

page.getTestResults = -> 
  (@.evaluate -> window.TEST_RESULTS)

page.hasTestRunCompleted = -> 
  @.getTestResults()?

page.didAllTestsPass = ->
  return false unless @.hasTestRunCompleted()

  for own test_name, test_result of @.getTestResults()
    return false if test_result.result != 'passed'

  true

url = "file://localhost#{__file__}/phantom_runner.html"

page.open url, -> page.startTestRun()

waitFor
  timeout: 5000
  testFn: -> page.hasTestRunCompleted()
  onSuccess: -> 
    phantom.exit( if page.didAllTestsPass() then 0 else 1 )
  onTimeout: -> 
    console.log( 'tests took too long. Aborting.' )
    phantom.exit(10)
  

#phantom.exit(1)

