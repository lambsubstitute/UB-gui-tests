Given(/^I add the product "([^"]*)" to the basket$/) do |arg|
  add_product_to_basket(arg)
end

Then(/^the item in the basket should have the seller "([^"]*)"$/) do |arg|
  item_in_basket_displays_shop(arg)
end

And(/^the item in the basket should have the title "([^"]*)"$/) do |arg|
  item_with_name_is_in_basket(arg)
end

And(/^the checkout button should be disabled$/) do
  checkout_button_is_disabled
end

And(/^I enter the telephone number$/) do

end

And(/^I enter the telephone number "(.*)"$/) do |arg|
  login_with_phone_number(arg)
end

And(/^click continue$/) do
  click_continue
end

And(/^I enter the address "(.*)"$/) do |arg|
  add_address(arg)
end

Given(/^I empty the basket$/) do
  empty_basket
end

And(/^I add the payment card "([^"]*)"$/) do |arg|
  add_payment_card(arg)
end

And(/^I select the address "(.*)"$/) do |arg|
  select_address(arg)
end

And(/^I select a size$/) do
  select_product_size
end

When(/^I complete the purchase$/) do
  complete_purchase
end

Given(/^I remove all addresses, cards, items from the basket$/) do
  add_product_to_basket('http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2')
  login_with_phone_number('07568091557')
  remove_saved_cards
  remove_added_addresses
  empty_basket
end

Then(/^I should be presented with the wait for confirmation from shop message$/) do
  @browser.h4(:class, 'ub-subtitle').wait_until_present(120)
  placing_order_page_text = @browser.h4(:class, 'ub-subtitle').text
  puts placing_order_page_text
  assert placing_order_page_text == "Your order is now being placed with
the retailer. You'll soon receive an email confirmation from them directly."
end