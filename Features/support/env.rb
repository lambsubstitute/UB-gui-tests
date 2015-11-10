require 'watir-webdriver'
require 'rspec'
require 'webdriver-user-agent'
require 'chunky_png'
require 'test/unit'
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'rubygems'
require 'watir-webdriver-performance'




Before do |scenario|
  puts "starting the mother fucking tests"
  set_ENV_variable_defaults
  debug_output("====================================")
  debug_output("***********ENVIRONMENT**************")
  debug_output("BROWSER     = #{ ENV['BROWSER']}")
  debug_output("ORIENTATION = #{ ENV['ORIENTATION']}")
  debug_output("REBASE      = #{ ENV['REBASE']}")
  debug_output("ENVIRONMENT = #{ ENV['ENVIRONMENT']}")

  start_browser(scenario)
end

def debug_output(output)
  puts output
end


def start_browser(scenario)
  #puts VISA
  browser = nil
  count = 0
  while browser == nil
    #begin
      if ENV['BROWSER'].include? "firefox"
        puts "tryng to start the mother fucking firefox"
        browser = start_firefox(scenario)
      elsif ENV['BROWSER'].include? "chrome"
        browser = start_chrome
      elsif ENV['BROWSER'].include? "headerless"
        browser = start_headerless
      elsif ENV['BROWSER'].include? "android_emulator"
        browser = start_remote_android_webdriver
      elsif ENV['BROWSER'].include? "browserstack"
        browser = start_browserstack
      end
  end
  set_urls
  @browser = browser
end

After do |scenario|
  #if scenario.failed?
    #takeFailedScenarioScreenshot(scenario)
  #end

  #@browser.close
end

at_exit do
  #@browser.close
end


