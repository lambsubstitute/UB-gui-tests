When(/^I request a api user token with a valid api key$/) do
  response = request_api_user_token
  puts 'body'
  puts response.body
  puts 'code'
  response.code
  puts 'message'
  response.message
  puts 'headers inspects'
  response.headers.inspect
end

Then(/^I should receive a valid token$/) do
  body_text = @response.body
  body_text = body_text.to_s
  assert body_text.include? '"status":"success"'
  assert body_text.include? '"appId":46,"countryId":1,"token":"'
end

Given(/^I have a user token$/) do
  request_api_user_token
  @user_token = extract_user_token(@response)
end

def request_api_user_token
  @add_product = false
  @browser.close
  api_auth_host = API_BASE + 'oauth/issue'
  response = HTTParty.post(api_auth_host, :body => 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b')
  @response = response
  return @response
end

def request_crawl_on_product(user_token, product_url)
  api_prod_crawl_url = API_BASE + 'products/crawl'
  product_uri  = URI(product_url)
  response = HTTParty.post(api_prod_crawl_url, :body => 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b&' + '&url=' + product_uri.to_s + '&wait=true')
  @crawl_response = response
  puts @crawl_response.body
  return @crawl_response
end

def extract_user_token(response)
  parsed_status = JSON.parse(response.body, :symbolize_names => true)
  token =  parsed_status.fetch(:access_token)
 # token = response_body.match(/"token":".*scope/)
 # token = token.to_s.gsub('"token":"', '').gsub('","scope', '')
  puts 'extracted user token'
  puts token
  return token
end

When(/^I request pre crawl on the product url "([^"]*)"$/) do |arg|
  get_data_from_request_crawl_on_product(arg)
end

def get_data_from_request_crawl_on_product(product_url)
  crawl_results = request_crawl_on_product(@user_token, product_url)
  @parsed_response = JSON.parse(crawl_results.body, :symbolize_names => true)
  puts @parsed_response
  pretty_str = JSON.pretty_unparse(@parsed_response)
  puts pretty_str
end

Then(/^I should receive the data:$/) do |table|
  puts '======================================='
  puts @parsed_response.fetch(:status)
  puts @parsed_response.fetch(:product)
  puts @parsed_response
  #product = nil
  product_array = Array.new
  @parsed_response.each do |key, val|
    puts "#{key} => #{val}" # prints each key and value.
    if key == :product
      product_array.push(val)
    end
  end

  puts product_array.length
  product_array.each do |product|
    puts product.fetch(:price)
    puts product.fetch(:url)
  end

end

def get_product_json(crawl_data)
  puts 'looking for product in crawl data'
  crawl_data.each do |key, val|
    puts "#{key} => #{val}" # prints each key and value.
    if key == :product
      puts "returning product : " + val.to_s
      return val
    end
  end
end

def get_price_json_from_product(product_json)
  puts 'looking for price in product'
  product_json.each do |key, val|
    puts "#{key} => #{val}" # prints each key and value.
    if key == :price
      puts "returning price : " + val.to_s
      return val
    end
  end
end

def get_currency_json_from_price(price_json)
  puts 'looking for currency in price'
  price_json.each do |key, val|
    puts "#{key} => #{val}" # prints each key and value.
    if key == :currency
      puts "returning currency info : " + val.to_s
      return val
    end
  end
end

def get_value_from_json_for_key(key_lookup, json)
  #puts key_lookup
  key_sym = key_lookup.to_sym
  json.each do |key, val|
   # puts "#{key} => #{val}" # prints each key and value.
    if key == key_sym
      puts "returning requested value for #{key_lookup} : " + val.to_s
      return val
    end
  end
end

Then(/^the currency should have the code "([^"]*)" and the symbol "([^"]*)"$/) do |arg1, arg2|
  product_json = get_product_json(@parsed_response)
  price_json = get_price_json_from_product(product_json)
  currency_json = get_currency_json_from_price(price_json)
  puts currency_json
  assert currency_json.fetch(:code) == arg1
  assert currency_json.fetch(:symbol) == arg2
end

When(/^I request the status of the shop "(.*)"$/) do |arg|
  request_shop_supported_status(arg)
end

def request_shop_supported_status(shop_url)
  api_prod_crawl_url = API_BASE + 'shop/scriptexists?'
  shop_uri  = URI(shop_url)
  response = HTTParty.post(api_prod_crawl_url, :body => 'url=' + shop_uri.to_s)
  @shop_supported_response = response
  puts @shop_supported_response.body
  return @shop_supported_response
end

Then(/^the status should be supported$/) do
  parsed_status = JSON.parse(@shop_supported_response.body, :symbolize_names => true)
  puts parsed_status.fetch(:status)
  assert parsed_status.fetch(:status) == 'ok'
end