desc 'use Guard to compile client-side assets (e.g. coffeescript => javascript)'
task :compile do
  require 'guard'
  Guard.setup :guardfile => 'Guardfile'
  Guard.run_all 
end

desc 'run client-side specs using PhantomJS'
task :spec do
  sh 'phantomjs spec/phantom_runner.coffee'
end

