Given(/^I add the product "([^"]*)" to the basket$/) do |arg|
  add_product_to_basket(arg)
end

def add_product_to_basket(product_url)
  @browser.goto(@base_url)
  @browser.goto(@base_url + product_url)
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
  checkout_class = @browser.link(:id, 'checkout').attribute_value('class')
  assert (checkout_class.include? 'disabled'), checkout_class + ' did not contain disabled'
end

And(/^I enter the telephone number$/) do

end

And(/^I enter the telephone number "(.*)"$/) do |arg|
  login_with_phone_number(arg)
end

def login_with_phone_number(phnone_no)
  @browser.link(:id, 'checkout').wait_until_present
  @browser.span(:text, '+ Add Personal Info').wait_until_present
  sleep 1
  @browser.send_keys :space
  @browser.send_keys :space

  @browser.span(:text, '+ Add Personal Info').click
  @browser.input(:id, 'email').wait_until_present
  @browser.input(:id, 'phone').wait_until_present


  @browser.text_field(:id, 'email').set 'keith.ford1980@googlemail.com'
  @browser.text_field(:id, 'phone').set phnone_no
  @browser.button(:text, 'Continue').click

  @browser.execute_script('window.confirm("go get your phone and enter the pin you feckless dullard");')
  @browser.alert.wait_while_present(120)
  @browser.link(:id, 'checkout').wait_until_present(120)
end


And(/^click continue$/) do
  @browser.button(:text, 'Continue').wait_until_present
  @browser.button(:text, 'Continue').click
end

And(/^I enter the address "(.*)"$/) do |arg|
  # address not actually used until the flow is sorted, then
  # todo add address variable arg to form
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present


  @browser.send_keys :space
  @browser.send_keys :space
  sleep 0.5

  @browser.span(:text, '+ Add Delivery Address').click
  @browser.text_field(:id, 'firstname').wait_until_present
  @browser.text_field(:id, 'firstname').set 'Auatomation'
  @browser.select(:id, 'title').select 'Mr'
  @browser.text_field(:id, 'lastname').set 'Evangalist'
  @browser.text_field(:id, 'suggest').set arg
  @browser.link(:text, '27-31 Clerkenwell Close, London').wait_until_present
  sleep 1
  @browser.link(:text, '27-31 Clerkenwell Close, London').wait_until_present
  @browser.link(:text, '27-31 Clerkenwell Close, London').click
  @browser.text_field(:id, 'company').wait_until_present
  @browser.text_field(:id, 'company').set 'UB'
  @browser.div(:class, "loading-bg").wait_while_present
  @browser.button(:text, 'Save address').click

  # todo go back in and select address
end

Given(/^I empty the basket$/) do
  empty_basket
end

def remove_added_addresses
  delivery_div = nil
  @browser.divs.each do |div|
    if div.label(:text,'Delivery').exist?
      delivery_div = div
    end
  end

puts 'removing addresses'
  begin
    @browser.div(:id, 'ub-loading-indicator').wait_while_present
    @browser.send_keys :space
    @browser.send_keys :space

    delivery_div.div(:text,/Auatomation Evangalist/).click
    @browser.div(:class, 'ub-page').wait_until_present
    sleep 1
    address_links = Array.new
    @browser.links.each do |link|
      if link.attribute_value('class') == 'ub-list-action'
        address_links.push(link.href)
      end
    end

    address_links.each do |address|
      @browser.goto(address)
      @browser.link(:text, 'Delete address').wait_until_present
      @browser.link(:text, 'Delete address').click
    end
  rescue
  end
  @browser.goto(@base_url)

  puts 'finished removintg addresses'
end

def empty_basket
  @browser.goto(@base_url + 'basket')
  @browser.div(:id, 'ub-basket-contents').wait_until_present

  while (@browser.text.include? "You haven't added anything to your basket.") == false

    @browser.div(:id, 'ub-loading-indicator').wait_while_present
    exit_flag = false
    @browser.links.each do |link|
      break if exit_flag == true
      if exit_flag == false
        if (link.attribute_value('class') == 'remove-item needsclick') && (link.visible? == true)
          link.click
          exit_flag = true
          @browser.div(:id, 'ub-loading-indicator').wait_while_present
        end
      end
    end
    @browser.goto(@base_url + 'basket')
  end
end

def remove_saved_cards
  payments_div = nil
  @browser.divs.each do |div|
    if div.label(:text,'Payment').exist?
     # puts 'found master payments div'
      payments_div = div
      #puts payments_div.text
    end
  end


  puts "removing saved cards"
  @browser.send_keys :space
  @browser.send_keys :space
  if payments_div.span(:text, /1111/).present?
    payments_div.span(:text, /1111/).click
  end
  begin
    @browser.links.each do |link|
      if link.attribute_value('class') == 'ub-list-action'
        link.click
        @browser.div(:id, 'ub-loading-indicator').wait_while_present
      end
    end
  rescue
  end
  puts 'finsihed removing saved cards'
  @browser.goto(@base_url)
end

And(/^I add the payment card "([^"]*)"$/) do |arg|
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Payment Card').wait_until_present
  @browser.span(:text, '+ Add Payment Card').click

  @browser.text_field(:id, 'number').wait_until_present
  @browser.text_field(:id, 'number').click
  @browser.text_field(:id, 'number').set arg
  @browser.text_field(:id, 'expiryDate').set '1220'
  @browser.text_field(:id, 'cvv2').set '222'
  @browser.text_field(:id, 'name').set 'kw ford'
  @browser.button(:id, 'save-card').click
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  # sleep 1000000
end

And(/^I select the address "(.*)"$/) do |arg|
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').click
  address_part = Regexp.new(arg)
  @browser.link(:text, address_part).wait_until_present
  @browser.link(:text, address_part).click
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end

And(/^I select a size$/) do
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.selects.each do |select|
    if select.attribute_value('name') == 'notused'
      options_array = Array.new
      options = select.options
      options.each do |option|
        options_array.push(option.value)
       # puts option.value
      end
      if options_array.size > 2
        select.select options_array[1]
      end
    end
  end
  #@browser.select(:name, 'notused').select 'UK 4'
end

When(/^I complete the purchase$/) do
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.link(:id, 'checkout').click
  @browser.link(:id, 'checkout').wait_while_present
end

Given(/^I remove all addresses, cards, items from the basket$/) do
  add_product_to_basket('http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2')
  login_with_phone_number('07568091557')
  remove_saved_cards
  remove_added_addresses
  empty_basket
end