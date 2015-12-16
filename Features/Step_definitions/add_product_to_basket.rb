Given(/^I add the product "(.*)" to the basket$/) do |arg|
  add_product_to_basket(arg)
end

Given(/^I add the default product to the basket$/) do
  DEFAULT_PRODUCT = "http://www.forever21.com/UK/Product/Product.aspx?BR=f21&Category=shoes&ProductID=2000178940&VariantID=&utm_source=6E6QwAp3j7Q&utm_medium=affiliate&utm_campaign=linkshare_f21"
  add_product_to_basket(DEFAULT_PRODUCT)
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
  select_all_product_attributes
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

Given(/^I have a defined UB cookie$/) do
  add_ub_cookie
end

def add_ub_cookie
  expiry_date = DateTime.new(2016,12,3)
  puts 'adding cookie'
  @browser.cookies.add @user_cookie_name, @user_cookie_value, secure: false, path: '/', expires: expiry_date, domain: @user_cookie_domain
  cookies  = @browser.cookies.to_a
  cookies.each do |cooky|
    puts cooky
  end
end

Given(/^I add the product "([^"]*)" to the basket from the country "([^"]*)"$/) do |arg1, arg2|
  @country = arg2
  add_product_to_basket(arg1)
end