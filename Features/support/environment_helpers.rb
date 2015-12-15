def set_ENV_variable_defaults()
  puts "setting env defaults"
  #SET DEFAULT ENV VARIABLES
  if ENV['BROWSER'] == nil
    ENV['BROWSER'] = "firefox"
  end

  if ENV['PLATFORM'] == nil
    ENV['PLATFORM'] = "desktop"
  end

  if ENV['ORIENTATION'] == nil
    ENV['ORIENTATION'] = "portrait"
  end

  if ENV['REBASE'] == nil
    ENV['REBASE'] = "false"
  end

  if ENV['ENVIRONMENT'] == nil
    ENV['ENVIRONMENT'] = "za"
  end



  if ENV['DEBUG'] == "full"
    @cookie_debug = true
    @basket_debug = true
    @debug_log = true
  elsif ENV['DEBUG'] == "cookie"
    @cookie_debug = true
    @basket_debug = false
    @debug_log = false
  end
  puts "finished setting env variables"
end



def set_firefox_driver()
  #set the browser heights and widths as chrome requires an override of the browser widths to be set manually
  #this is required for mobile testing and can be changed if the default sizes of mobile res changes
  #when adding more device platforms for with specific resolutions make sure they are set here
  #set timeouts
  #driver = driver.manage.timeouts.implicit_wait = 300
  #driver = driver.manage.timeouts.script_timeout = 300
  #driver = driver.manage.timeouts.page_load = 300

  ##set the driver for the browser user agent if it is required
  if ENV['BROWSER'] == "firefox"
    #do nothing as this is a straight firefox call
    ENV['PLATFORM'] = nil


  elsif ENV['BROWSER'].include? "android_tablet"
    #set the platform user agent to :android_tablet
    debug_output("setting user agent to :android_tablet")
    ENV['PLATFORM'] = "android_tablet"
    set_tablet_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :android_tablet, :orientation => :landscape)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :android_tablet, :orientation => :portrait)
    end


  elsif ENV['BROWSER'].include? "ipad"
    #set the platform user agent to :ipad
    debug_output("setting user agent to :ipad")
    ENV['PLATFORM'] = ":ipad"
    set_tablet_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :ipad, :orientation => :landscape)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :ipad, :orientation => :portrait)
    end


  elsif ENV['BROWSER'].include? "android_phone"
    @mobile_mode = true
    #set the platform user agent to: android_phone
    debug_output("setting user agent to :android_phone")
    ENV['PLATFORM'] = ":android_phone"
    set_phone_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :android_phone, :orientation => :landscape)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :android_phone, :orientation => :portrait)
    end


  elsif ENV['BROWSER'].include? "iphone"
    #set the platform user agent to :iphone
    debug_output("setting user agent to :iphone")
    ENV['PLATFORM'] = ":iphone"
    @mobile_mode = true
    set_phone_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :landscape)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :portrait)
    end
  end


  return driver
end




def set_chrome_driver()
  #set the browser heights and widths as chrome requires an override of the browser widths to be set manually
  #this is required for mobile testing and can be changed if the default sizes of mobile res changes
  #when adding more device platforms for with specific resolutions make sure they are set here
  #set timeouts
  #driver = driver.manage.timeouts.implicit_wait = 300
  #driver = driver.manage.timeouts.script_timeout = 300
  #driver = driver.manage.timeouts.page_load = 300
  ##set the driver for the browser user agent if it is required
  #caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"user-data-dir" => [ 'C:\Users\keith.ford\AppData\Local\Google\Chrome\User Data\Profile 1' ]})
  #options.addArguments();
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 120 # seconds
  #driver = Selenium::WebDriver.for(:remote, :http_client => client)
  if ENV['BROWSER'] == "chrome"
    #do nothing as this is a straight firefox call
    ENV['PLATFORM'] = nil


  elsif ENV['BROWSER'].include? "android_tablet"
    #set the platform user agent to :android_tablet
    debug_output("setting user agent to :android_tablet")
    ENV['PLATFORM'] = "android_tablet"
    set_tablet_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :android_tablet, :orientation => :landscape, :http_client => client)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :android_tablet, :orientation => :portrait, :http_client => client)
    end


  elsif ENV['BROWSER'].include? "ipad"
    #set the platform user agent to :ipad
    debug_output("setting user agent to :ipad")
    ENV['PLATFORM'] = ":ipad"
    set_tablet_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :ipad, :orientation => :landscape, :http_client => client)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :ipad, :orientation => :portrait, :http_client => client)
    end


  elsif ENV['BROWSER'].include? "android_phone"
    @mobile_mode = true
    #set the platform user agent to: android_phone
    debug_output("setting user agent to :android_phone")
    ENV['PLATFORM'] = ":android_phone"
    set_phone_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :android_phone, :orientation => :landscape, :http_client => client)
    else
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :android_phone, :orientation => :portrait, :http_client => client)
    end


  elsif ENV['BROWSER'].include? "iphone"
    @mobile_mode = true
    #set the platform user agent to :iphone
    debug_output("setting user agent to :iphone")
    ENV['PLATFORM'] = ":iphone"
    set_phone_orientation
    if ENV['ORIENTATION'] == "landscape"
      driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iphone, :orientation => :landscape)
    else
     # driver =  Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iphone, :orientation => :portrait)
      driver = Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iphone, :orientation => :portrait, :http_client => client)
    end
  end
  #driver.manage.timeouts.implicit_wait = 120

  return driver
end






def set_urls()
  if ENV['BASE_URL'] != nil
    @base_url = BASE_URL
  elsif ENV['ENVIRONMENT'] == "staging"
    @base_url = STAGING_BASE
    @user_cookie_name = 'ubsite.staging.sid'
    @user_cookie_value = 's%3AtaMXflvzxfhk40Ieuh8gBuYu.QUQOIbxPKwC0%2BjXURTHB1bac9WSV7wCRQn2TCD7QV9A'
    @user_cookie_domain = 'staging.ub.io'
  elsif ENV['ENVIRONMENT'] == "LIVE"
    @base_url = LIVE_BASE
    @user_cookie_name = 'ubsite..sid'
    @user_cookie_value = 's%3APdGwoQpnocfxbLxWFCaRftJF.BcR4lZNw0xM9ALrX2vJ%2B8ZFoTZOjavEFlu3FKcsvFIA'
    @user_cookie_domain = 'ub.io'
  elsif ENV['ENVIRONMENT'] == "za"
    @base_url = ZA_BASE
  elsif (ENV['ENVIRONMENT'] == "qa1") || (ENV['ENVIRONMENT'] ==  "QA1")
    @base_url = QA1_BASE
  elsif (ENV['ENVIRONMENT'] == "qa2") || (ENV['ENVIRONMENT'] == "QA2")
    @base_url = QA2_BASE                                                            y
  elsif ENV['ENVIRONMENT'] == "local"
    @base_url = "http://localhost/"
  elsif ENV['ENVIRONMENT'] == "beta"
    @base_url = "http://beta.just-eat.co.uk/"
  elsif ENV['ENVIRONMENT'] != nil
    @base_url = ENV['ENVIRONMENT']
  else
    puts "could not find a matching environment set of urls, setting qa1 urls as fall back default"
    @base_url = QA1_BASE
  end
  debug_output("the base url is: #{@base_url}")


  end
