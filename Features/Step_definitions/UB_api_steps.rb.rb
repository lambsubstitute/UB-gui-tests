When(/^I request a api user token with a valid api key$/) do
  request_api_user_token
end

Then(/^I should receive a valid token$/) do
  valid_user_token_exists
end


Given(/^I have a user token$/) do
  @user_token = get_user_token
end

When(/^I request pre crawl on the product url "([^"]*)"$/) do |arg|
  response = get_data_from_request_crawl_on_product(arg)
  puts '======================================='
  puts response.fetch(:status)
  puts response.fetch(:product)
  puts response
end



Then(/^I should receive the data:$/) do |table|
  product_array = Array.new
  @parsed_response.each do |key, val|
    puts "#{key} => #{val}" # prints each key and value.
    if key == :product
      product_array.push(val)
    end
  end
  product_array.each do |product|
    puts product.fetch(:price)
    puts product.fetch(:url)
  end
end


Then(/^the currency should have the code "([^"]*)" and the symbol "([^"]*)"$/) do |arg1, arg2|
  currency_json = get_currency_info_from_response(@parsed_response)
  assert currency_json.fetch(:code) == arg1
  assert currency_json.fetch(:symbol) == arg2
end


When(/^I request the status of the shop "(.*)"$/) do |arg|
  @shop_supported_response = request_shop_supported_status(arg)
end


Then(/^the status should be supported$/) do
  parsed_status = parse_json(@shop_supported_response.body)
  assert (parsed_status.fetch(:status) == 'ok'), parsed_status.fetch(:status).to_s + ' did not match the expected status of: "ok"'
end