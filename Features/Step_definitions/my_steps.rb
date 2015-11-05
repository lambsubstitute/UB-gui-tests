Given(/^I add the product "([^"]*)" to the basket$/) do |arg|
 # @browser.goto(@base_url)
  @browser.goto(@base_url + arg)
  sleep 10
end