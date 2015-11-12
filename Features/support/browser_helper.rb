def start_firefox(scenario)
  puts "starting firefox"
  count = 0
  browser = nil
  puts "mother fuxker"
  driver =  set_firefox_driver
  @screeny_name =  ENV['BROWSER'] + "_" + ENV['ORIENTATION']
  @screeny_name = @screeny_name + "_" + scenario.name

  profile = Selenium::WebDriver::Firefox::Profile.new
  puts driver

  #firefox can sometimes fail to start because of a number of reasons, this will force a catch and retry 3 times
  #to increase the number of times it tries increase the check on the count variable below
  while browser == nil && count < 3
    begin
      puts "trying to start the browser"
      if driver != nil
        puts "starting browser with driver"
        browser = Watir::Browser.new driver, :profile => profile
        browser.driver.manage.timeouts.implicit_wait = 2
        browser.driver.manage.timeouts.page_load = 1000
        browser.driver.manage.timeouts.script_timeout = 1000
        debug_output("platform and orientation details set at: #{@screeny_name}")
      else
        puts "starting browser without driver"
         browser = Watir::Browser.new :firefox
         browser.driver.manage.timeouts.implicit_wait = 2
         browser.driver.manage.timeouts.page_load = 1000
         browser.driver.manage.timeouts.script_timeout = 1000
      end
    rescue Exception=>e
      sleep 10
      puts "failed to open firefox, this is a matter of timeouts or the server could be under to much load to be able to spin it up within 60 seconds"
      count = count + 1
    end
  end

  if browser != nil
    set_browser_size(browser)
    return browser
  else
    puts "could not start firefox correctly due to exception #{e}"
  end
end


def start_browserstack()
 # @mobile_mode = true
  caps = Selenium::WebDriver::Remote::Capabilities.new
  caps[:browserName] = 'iPhone'
  caps[:platform] = 'MAC'
  caps['device'] = 'iPhone 4S (6.0)'
  browser = Selenium::WebDriver.for(:remote,
                                   :url => "http://keithford1:HRr6gXkbne38CuH4DpGg@hub.browserstack.com/wd/hub",
                                   :desired_capabilities => caps)
  return browser
end


def start_chrome()
  driver =  set_chrome_driver()
  @screeny_name = ENV['BROWSER'] + "_" + ENV['ORIENTATION']
  debug_output("loading chrome")
  profile = Selenium::WebDriver::Chrome::Profile.new
  #, native_events: true
  if driver != nil
    puts "loading chrome with the extension"
    debug_output("starting chrome with user agent driver details")
    browser = Watir::Browser.new  driver #, :switches => ['--load-extension =C:\Users\keith.ford\AppData\Local\Google\Chrome\User Data\Default\Extensions\oilipfekkmncanaajkapbpancpelijih\1.9.1_0'] #:profile => profile     "--load-extension=C:/autorefresh/Auto-Refresh-Plus_v1.9.1.crx"
  else
    puts "loading chrome the other way"
    debug_output("starting chrome the old fashioned way")
    browser = Watir::Browser.new :chrome #,  :switches => ['--load-extension=C:\Users\keith.ford\AppData\Local\Google\Chrome\User Data\Default\Extensions\oilipfekkmncanaajkapbpancpelijih\1.9.1_0'] #:profile => profile
  end
  set_browser_size(browser)
  debug_output("platform and orientation details set at: #{@screeny_name}")

  set_browser_size(browser)
  debug_output("platform and orientation details set at: #{@screeny_name}")

  #close_window_with_title("Thank you for using Auto Refresh")
  #browser.windows.last.close
  return browser
end



def start_headerless()
  browser = Watir::Browser.new :phantomjs
  return browser
end


def start_remote_android_webdriver()
  include Selenium::WebDriver::DriverExtensions::HasTouchScreen
  caps = Selenium::WebDriver::Remote::Capabilities.android(:javascript_enabled => true, :css_selectors_enabled=>true)
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 480
  browser = Selenium::WebDriver.for(
      :remote,
      :url => "http://localhost:8080/wd/hub",
      :http_client => client,
      :desired_capabilities => caps)
  return browser
end



def set_browser_size(browser)
  if @browser_width && @browser_width != nil
    debug_output("resizing the browsers height and width")
    browser.window.resize_to(@browser_width, @browser_height)
  elsif @browser_width == nil && @browser_height != nil
    debug_output("resizing the browsers height of #{@browser_height}, but using the existing width")
    browser_width = browser.window.size.width
    browser.window.resize_to(browser_width, @browser_height)
  end
  debug_output("browser has been set to a height of #{browser.window.size.height} and a width of #{browser.window.size.width}")
end



def set_tablet_orientation()
  #browser_width overrides are required to set chrome up properly as there is a bug in the user agent on resizing
  #@mobile_mode = true
  if ENV['BROWSER'].include? "chrome"
    debug_output("setting chrome height and width overrides")
    if ENV['ORIENTATION'] == "landscape"
      debug_output("setting landscape for tab")
      @browser_width = 800
    elsif ENV['ORIENTATION'] == "portrait"
      debug_output("setting portrait for tab")
      @browser_width = 600
    end
    @browser_height = 3200
  end
end


def set_phone_orientation()
  #browser_width overrides are required to set chrome up properly as there is a bug in the user agent on resizing
  @mobile_mode = true
  if ENV['BROWSER'].include? "chrome"
    debug_output("setting chrome height and width overrides")
    if ENV['ORIENTATION'] == "landscape"
      debug_output("setting landscape for phone")
      @browser_width = 480
    elsif ENV['ORIENTATION'] == "portrait"
      debug_output("setting portrait for phone")
      @browser_width = 320
    end
   @browser_height = 950
  end
end



def display_cookies(*args)
  puts @cookie_debug
  if @cookie_debug == true

    if args != nil
      puts "MESSAGE -"
      puts args
    end
    cookies = Array.new
    cookies = @browser.cookies.to_a
    cookies.each do |cook|
      puts cook
      puts "==========="
    end
  end
end






