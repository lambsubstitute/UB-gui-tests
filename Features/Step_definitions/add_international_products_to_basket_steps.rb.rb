# encoding: UTF-8
Given(/^the basket is empty with no saved details$/) do
  #@browser.goto(@base_url + '/basket')
  remove_saved_cards
  remove_added_addresses
  empty_basket
  sleep 1000000
end

And(/^it should have an item in it$/) do
  basket = Basket.new(@browser)
  product_title = basket.get_first_basket_item_name
  puts product_title
  assert product_title != nil
end

Then(/^I should see the basket$/) do
  basket = Basket.new(@browser)
  assert basket.basket_present?
end

Given(/^I add a uk user cookie$/) do
  add_ub_cookie
  @browser.goto(@base_url + 'basket')
end

Given(/^I have a german product in the basket$/) do
  @country = 'de'
  add_product_to_basket(DEFAULT_DE_PRODUCT)
end

When(/^i try to add a uk product$/) do
  add_product_to_basket_with_no_waits_or_checks(DEFAULT_PRODUCT)
end

Then(/^the item should not be added to the basket$/) do
  @browser.div(:id, 'out-of-stock-message').wait_until_present(120)
  assert @browser.text.include? 'Oops'
  assert @browser.text.include? 'This item appears to be'
  assert @browser.text.include? 'out of stock.'
end

And(/^the item currency should match the "([^"]*)"$/) do |arg|
  basket = Basket.new(@browser)
  price = basket.get_item_price
  puts price
  assert price.include? arg
end

And(/^the basket subtotals should have the currency "([^"]*)"$/) do |arg|
  basket = Basket.new(@browser)
  totals_price = basket.get_totals_price
  puts totals_price
  assert totals_price.include? arg
end


