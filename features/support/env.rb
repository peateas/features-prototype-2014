require 'log4r'
require 'rspec/expectations'
require 'capybara/cucumber'
require 'capybara/poltergeist'

include Log4r

def logger(name)
  unless defined?(formatter) and formatter
    formatter = PatternFormatter.new(:pattern => '%d %c %l - %m')
  end
  logger = Log4r::Logger[name]
  unless logger
    logger = Log4r::Logger.new(name)
    console = Outputter[:console]
    unless console
      console = Log4r::StderrOutputter.new(:console)
      console.level=WARN
      # noinspection RubyScope
      console.formatter=formatter
    end
    log_name = "logs/#{logger.name}.log"
    log = Outputter[log_name]
    unless log
      log=FileOutputter.new(:default, :filename => log_name)
      log.formatter=formatter
    end
    logger.add(console, log)
  end
  logger
end

if ENV['IN_BROWSER']
  # On demand: non-headless tests via Selenium/WebDriver
  # To run the scenarios in browser (default: Firefox), use the following command line:
  # RUN_IN_BROWSER=true bundle exec cucumber
  # or (to have a pause of 1 second between each step):
  # RUN_IN_BROWSER=true PAUSE=1 bundle exec cucumber
  Capybara.default_driver = :selenium
  AfterStep do
    sleep (ENV['PAUSE'] || 0).to_i
  end
else
  # DEFAULT: headless tests with poltergeist/PhantomJS
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
end

Capybara.app_host = 'http://tempo.io'
Capybara.run_server = false
Capybara.default_wait_time = 5
Capybara.default_selector = :css

World(RSpec::Matchers)


Before do |scenario|
  case scenario
    when Cucumber::Core::Ast::Scenario
      feature = scenario.feature
      title=scenario.title
    # when Cucumber::Core::Ast::OutlineTable::ExampleRow
    #   feature = scenario.scenario_outline.feature
    #   title = scenario.scenario_outline.title
    else
      feature = nil
      title = ''
  end
  if feature
    location = feature.location.file
    inside = feature.title
  else
    location = ''
    inside = ''
  end
  if location.empty?
    log = 'error'
  else
    path = File.dirname(location)
    log = File.basename(path)
  end
  $feature=logger('feature')
  $logger=logger(log)
  $feature.info("***** Using log '#{log}' for Scenario '#{title}' in Feature '#{inside}'")
  $logger.info("***** Logging here for for Scenario '#{title}' in Feature '#{inside}'")
end

