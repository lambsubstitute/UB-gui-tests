# encoding: utf-8

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
  access_json = JSON.generate(@user_token)
  access_token_parsed = JSON.parse(access_json, :symbolize_names => true)
  puts access_token_parsed.fetch(:userId)
  puts HTTParty.get('http://api.ub.io/user/me',  :headers => {'userId' => access_token_parsed.fetch(:userId).to_s,
                                                              'appId' => access_token_parsed.fetch(:appId).to_s,
                                                              'countryId' => access_token_parsed.fetch(:countryId).to_s,
                                                              'token' => access_token_parsed.fetch(:token).to_s,
                                                              'scope' => access_token_parsed.fetch(:scope).to_s,
                                                              'expiryDate' => access_token_parsed.fetch(:expiryDate).to_s,
                                                              'id' => access_token_parsed.fetch(:id).to_s})
  puts @prod_id
  api_auth_host = API_BASE + 'basket/add/' + @prod_id
  puts api_auth_host
  response = HTTParty.post(api_auth_host, :headers => {'userId' => access_token_parsed.fetch(:userId).to_s,
                                                       'appId' => access_token_parsed.fetch(:appId).to_s,
                                                       'countryId' => access_token_parsed.fetch(:countryId).to_s,
                                                       'token' => access_token_parsed.fetch(:token).to_s,
                                                       'scope' => access_token_parsed.fetch(:scope).to_s,
                                                       'expiryDate' => access_token_parsed.fetch(:expiryDate).to_s,
                                                       'id' => access_token_parsed.fetch(:id).to_s},
                                          :body => {:productId => @prod_id})
  @response = response
  puts response.body
end

Then(/^the iem requested should be in the new basket$/) do
  access_json = JSON.generate(@user_token)
  access_token_parsed = JSON.parse(access_json, :symbolize_names => true)
  puts access_token_parsed.fetch(:userId)
  api_auth_host = API_BASE + 'basket/get'
  puts api_auth_host
  response = HTTParty.get(api_auth_host, :headers => {'userId' => access_token_parsed.fetch(:userId).to_s,
                                                       'appId' => access_token_parsed.fetch(:appId).to_s,
                                                       'countryId' => access_token_parsed.fetch(:countryId).to_s,
                                                       'token' => access_token_parsed.fetch(:token).to_s,
                                                       'scope' => access_token_parsed.fetch(:scope).to_s,
                                                       'expiryDate' => access_token_parsed.fetch(:expiryDate).to_s,
                                                       'id' => access_token_parsed.fetch(:id).to_s})
  puts response.body
  assert response.body.include? '"subtotal":{"value":345,"currency":{"code":null,"symbol":"£"},"text":"£345.00"},"total":{"value":355,"currency":{"code":null,"symbol":"£"},"text":"£355.00"},"transactions":[{"shop":{"id":"273","name":"Farfetch - Designer Luxury Fashion for Men &amp; Women"'
end