require 'watir-webdriver'
require 'rspec'
require 'webdriver-user-agent'
require 'chunky_png'
require 'test/unit'
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'rubygems'
require 'watir-webdriver-performance'
#include HTTParty
require 'HTTParty'


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
  # @browser.goto('http://bbc.com')
  # @browser.goto(@base_url)
  # add_product_to_basket('http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2')
  # remove_saved_cards
  # remove_added_addresses
  # empty_basket
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
  @browser.goto(@base_url + 'basket')
  @add_product = true
end

After do |scenario|
  #if scenario.failed?
  #takeFailedScenarioScreenshot(scenario)
  #end
  if scenario.failed?
    #check_console_log
 #   getLog('chrome')
  end
  if @add_product == true
    if @country == nil
      add_product_to_basket(DEFAULT_PRODUCT)
    elsif @country == 'de'
      add_product_to_basket(DEFAULT_DE_PRODUCT)
    elsif @country == 'fr'
      add_product_to_basket(DEFAULT_FR_PRODUCT)
    elsif @country == 'it'
      add_product_to_basket(DEFAULT_IT_PRODUCT)
    elsif @country == 'uk'
      add_product_to_basket(DEFAULT_PRODUCT)
    end
    remove_saved_cards
    remove_added_addresses
    empty_basket
  end
  @browser.close
end

at_exit do

end

def check_console_log
  console_log = @browser.driver.manage.get_log(:browser)
  if console_log != nil
    raise(console_log)
    puts console_log
  end
end

def getLog(type)
  data = @browser.execute :getLog, {}, :type => type.to_s
  Array(data).map do |l|
    LogEntry.new l.fetch('level'), l.fetch('timestamp'), l.fetch('message')
    puts LogEntry
  end
end


# Allows browser object to be shared across page object classes without declaring it in every po
module PageInitializer
  # initializer for page objects, generic @browser initializer/parser
  def initialize(browser)
    @browser = browser
  end
end


