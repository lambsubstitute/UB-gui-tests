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

  @browser.execute_script('window.confirm("go get your phone and enter the pin you feckless dullard");')
  @browser.alert.wait_while_present(120)
  @browser.link(:id, 'checkout').wait_until_present(120)
end


And(/^click continue$/) do
  @browser.button(:text,'Continue').wait_until_present
  @browser.button(:text,'Continue').click
end

And(/^I enter the address "(.*)"$/) do |arg|
  # address not actually used until the flow is sorted, then
  # todo add address variable arg to form
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present


  @browser.send_keys :space

  @browser.span(:text, '+ Add Delivery Address').click
  @browser.text_field(:id, 'firstname').wait_until_present
  @browser.text_field(:id, 'firstname').set 'Auatomation'
  @browser.select(:id, 'title').select 'Mr'
  @browser.text_field(:id, 'lastname').set 'Evangalist'
  @browser.text_field(:id, 'suggest').set '27-31 Clerkenwell Close'
  sleep 1
  @browser.link(:text, '27-31 Clerkenwell Close, London').wait_until_present
  @browser.link(:text, '27-31 Clerkenwell Close, London').click
  @browser.text_field(:id, 'company').wait_until_present
  @browser.text_field(:id, 'company').set 'UB'
  @browser.button(:text, 'Save address').click
end

Given(/^I empty the basket$/) do
  empty_basket
end

def remove_added_addresses
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present
  @browser.span(:text, '+ Add Delivery Address').click

  @browser.div(:class, 'ub-page').wait_until_present
  sleep 1
  address_links = Array.new
  @browser.links.each do |link|
    if link.attribute_value('class') == 'ub-list-action'
      address_links.push(link.href)
    end
  end

  address_links.each do |address|
    puts  address
    @browser.goto(address)
    @browser.link(:text, 'Delete address').wait_until_present
    @browser.link(:text, 'Delete address').click
  end
end

def empty_basket
  @browser.goto(@base_url + 'basket')
  @browser.div(:id, 'ub-basket-contents').wait_until_present

  while (@browser.text.include? "You haven't added anything to your basket.") == false
    @browser.div(:id, 'ub-loading-indicator').wait_while_present
    exit_flag = false
    @browser.links.each do |link|
    break if exit_flag == true
      if (link.attribute_value('class') == 'remove-item needsclick') && (exit_flag == false)
        link.click
        exit_flag = true
      end
    end
  end
end
