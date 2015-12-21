And(/^I know the product id for the product "(.*)"$/) do |arg|
  get_data_from_request_crawl_on_product(arg)
  puts @parsed_response
  product_json = get_product_json(@parsed_response)
  @prod_id = get_value_from_json_for_key('id', product_json).to_s
  puts @prod_id
end

When(/^I request through the api the item is added to the basket$/) do
  #sleep 100000
  puts @user_token
  puts JSON.generate(@user_token)
  puts HTTParty.get('http://api.ub.io/user/me',  :headers => {'access_token' => @user_token})
  api_auth_host = API_BASE + 'basket/add/:' + @prod_id
  puts api_auth_host
  response = HTTParty.post(api_auth_host, :header =>  @user_token)
  @response = response
  puts response
end