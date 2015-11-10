Given(/^I add the product "([^"]*)" to the basket$/) do |arg|
  @browser.goto(@base_url)
  @browser.goto(@base_url + arg)
  while @browser.text.include? 'Fetching product details'
    sleep 0.5
  end
  puts 'added item to basket, now sleeping for visible check'
  @browser.div(:id, 'ub-basket-contents').wait_until_present
end


Then(/^the item in the basket should have the seller "([^"]*)"$/) do |arg|
  assert (@browser.div(:class, 'ub-shop').text.include? arg), @browser.div(:class, 'ub-shop').text + ' did not include: ' + arg
end


And(/^the item in the basket should have the title "([^"]*)"$/) do |arg|
  product = @browser.div(:class, 'ub-product')
  assert (product.li(:class, 'ub-product-title').text.include? arg), product.li(:class, 'ub-product-title').text + ' did not include: ' + arg
end

And(/^the checkout button should be disabled$/) do
  @browser.link(:id, 'checkout').wait_until_present
  checkout_class =  @browser.link(:id, 'checkout').attribute_value('class')
  assert (checkout_class.include? 'disabled'), checkout_class + ' did not contain disabled'
end

And(/^I enter the telephone number$/) do

end

And(/^I enter the telephone number "(.*)"$/) do |arg|
  @browser.link(:id, 'checkout').wait_until_present
  @browser.span(:text, '+ Add Personal Info').wait_until_present


  @browser.send_keys :space

  @browser.span(:text, '+ Add Personal Info').click
  @browser.input(:id, 'email').wait_until_present
  @browser.input(:id, 'phone').wait_until_present


  @browser.text_field(:id, 'email').set 'keith.ford1980@googlemail.com'
  @browser.text_field(:id, 'phone').set arg
  @browser.button(:text,'Continue').click
end


And(/^click continue$/) do
  @browser.button(:text,'Continue').wait_until_present
  @browser.button(:text,'Continue').click
end

And(/^I enter the address "(.*)"$/) do |arg|
  @browser.link(:id, 'checkout').wait_until_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present


  @browser.send_keys :space

  @browser.span(:text, '+ Add Delivery Address').click
  @browser.input(:id, 'firstname').wait_until_present
  @browser.input(:id, 'phone').wait_until_present


  #@browser.text_field(:id, 'email').set 'keith.ford1980@googlemail.com'
  #@browser.text_field(:id, 'phone').set arg
  #@browser.button(:text,'Continue').click
end
