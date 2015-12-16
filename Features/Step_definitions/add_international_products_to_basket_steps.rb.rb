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
  basket_present = basket.basket_present?
  assert basket_present
end

Given(/^I add a uk user cookie$/) do
  add_ub_cookie
  @browser.goto(@base_url + 'basket')
end