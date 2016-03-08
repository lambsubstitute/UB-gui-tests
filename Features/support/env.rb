require 'watir-webdriver'
require 'rspec'
require 'webdriver-user-agent'
require 'chunky_png'
require 'test/unit'
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'rubygems'
require 'watir-webdriver-performance'
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
end

def debug_output(output)
  puts output
end


def start_browser(scenario)
  browser = nil
  count = 0
  while browser == nil
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
 # @browser.goto(@base_url + 'basket')
  @add_product = true
end

After do |scenario|
  if scenario.failed?
    screenshots(scenario.name.to_s , @browser)
  end
 # @clean_cards_flag = true
#  @clean_address_flag = true

  if @checkout_made_flag == true
    add_product_to_basket(@product_url)
  end


  if @add_product == true
    if @clean_cards_flag == true
      remove_saved_cards
    end
    if @clean_address_flag == true
      remove_added_addresses
    end
    empty_basket
  end
  @browser.close
end

at_exit do

end

def screenshots(scenario, browser)
  # build file name from the scenario name so its easy to identify against a specific test
  file_name = scenario
  # remove illegal file name chars
  file_name = file_name.gsub(' ', '_').gsub('/', ('_'))
  # make the screenshot directory if it doesnt exist
  Dir.mkdir('./screenshots') unless File.directory?('./screenshots')
  puts 'making a screen shot now as #[' + file_name + '_FAILED.png' + ']'

  # version 1 not working in ie with viewing the report, view report in ff for screenshots
  #window_debug_info
  browser.screenshot.save(file_name + '_FAILED.png')
  #end
  embed(file_name + '_FAILED.png', 'image/png')
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


