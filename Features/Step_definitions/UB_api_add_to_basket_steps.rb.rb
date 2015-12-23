# encoding: utf-8

And(/^I know the product id for the product "(.*)"$/) do |arg|
  get_data_from_request_crawl_on_product(arg)
  product_json = get_product_json(@parsed_response)
  @prod_id = get_value_from_json_for_key('id', product_json).to_s
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
  response = get_current_basket
  puts response.body
  assert response.body.include? '"subtotal":{"value":345,"currency":{"code":null,"symbol":"£"},"text":"£345.00"},"total":{"value":355,"currency":{"code":null,"symbol":"£"},"text":"£355.00"},"transactions":[{"shop":{"id":"273","name":"Farfetch - Designer Luxury Fashion for Men &amp; Women"'
end



And(/^I remove the item from the basket$/) do
  basket = get_current_basket
  #basket = basket.body
  basket_json = JSON.parse(basket.body, :symbolize_names => true)
  dump_pairs_for_inspection(basket_json)
  inner_basket = get_value_from_json_for_key('basket', basket_json)
  dump_pairs_for_inspection(inner_basket)
  transaction = get_value_from_json_for_key('transactions', inner_basket)
  dump_pairs_for_inspection(transaction)

  @line_id = /lines(.*)", :product/.match(transaction.to_s)
  @line_id = @line_id.to_s
  @line_id = @line_id.gsub('lines=>[{:id=>"','').gsub('", :product', '')
  puts @line_id

  puts 'transaction: ' + transaction.to_s
  puts @line_id
  response = remove_item_from_basket(@line_id)
  puts response.body
end


Then(/^my basket should be empty$/) do
  basket = get_current_basket
  basket_json = JSON.parse(basket.body, :symbolize_names => true)
  dump_pairs_for_inspection(basket_json)
  inner_basket = get_value_from_json_for_key('basket', basket_json)
  items_total = get_value_from_json_for_key('itemsTotal', inner_basket)
  puts items_total
  assert items_total == 0
end