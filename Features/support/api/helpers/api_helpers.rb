def build_headers(user_token)
  puts user_token
  access_json = JSON.generate(user_token)
  access_token_parsed = JSON.parse(access_json, :symbolize_names => true)
  puts access_token_parsed.fetch(:userId)
  headers = {'userId' => access_token_parsed.fetch(:userId).to_s,
             'appId' => access_token_parsed.fetch(:appId).to_s,
             'countryId' => access_token_parsed.fetch(:countryId).to_s,
             'token' => access_token_parsed.fetch(:token).to_s,
             'scope' => access_token_parsed.fetch(:scope).to_s,
             'expiryDate' => access_token_parsed.fetch(:expiryDate).to_s,
             'id' => access_token_parsed.fetch(:id).to_s}
  return headers
end

def get_current_basket
  access_json = JSON.generate(@user_token)
  access_token_parsed = parse_json(access_json)
  puts access_token_parsed.fetch(:userId)
  api_auth_host = API_BASE + 'basket/get'
  puts api_auth_host
  headers = build_headers(@user_token)
  response = HTTParty.get(api_auth_host, :headers => headers)
  return response
end

def remove_item_from_basket(line_id)
  api_auth_host = API_BASE + 'basket/remove/' + line_id
  puts api_auth_host
  headers = build_headers(@user_token)
  response = HTTParty.delete(api_auth_host, :headers => headers)
  return response
end



def dump_pairs_for_inspection(json)
  puts '===================================='
  puts 'dumping grouped json for inspection'
  json.each do |key, val|
    puts '------------------------'
    puts 'key: ' + key.to_s
    puts 'value: ' + val.to_s
  end
  puts '-----------------------'
  puts 'finish inspection'
  puts '===================================='
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
  puts 'precrawl url end point: ' + api_prod_crawl_url
  puts 'api end point call payload: ' + 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b&' + '&url=' + product_url + '&wait=true'
  product_uri  = URI(product_url)
  response = HTTParty.post(api_prod_crawl_url, :body => 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b&' + '&url=' + product_uri.to_s + '&wait=true')
  @crawl_response = response
  puts @crawl_response.body
  return @crawl_response
end

def extract_user_token(response)
  parsed_status = parse_json(response.body)
  token =  parsed_status.fetch(:access_token)
  puts 'extracted user token'
  puts token
  return token
end

def parse_json(json_to_parse)
  return JSON.parse(json_to_parse, :symbolize_names => true)
end

def get_product_json(crawl_data)
  puts 'looking for product in crawl data'
  return get_value_from_json_for_key('product', crawl_data)
end

def get_price_json_from_product(product_json)
 puts 'looking for price in product'
 return get_value_from_json_for_key('price', product_json)
end

def get_currency_json_from_price(price_json)
  puts 'looking for currency in price'
  return get_value_from_json_for_key('currency', price_json)
end

def get_basket_json(crawl_data)
  puts 'looking for product in crawl data'
  return get_value_from_json_for_key('basket', crawl_data)
end

def get_transaction_json(crawl_data)
  puts 'looking for product in crawl data'
  return get_value_from_json_for_key('transaction', crawl_data)
end

def get_value_from_json_for_key(key_lookup, json)
  key_sym = key_lookup.to_sym
  json.each do |key, val|
    # puts "#{key} => #{val}" # prints each key and value.
    if key == key_sym
      puts "returning requested value for #{key_lookup} : " + val.to_s
      return val
    end
  end
end


def request_shop_supported_status(shop_url)
  api_prod_crawl_url = API_BASE + 'shop/scriptexists?'
  shop_uri  = URI(shop_url)
  response = HTTParty.post(api_prod_crawl_url, :body => 'url=' + shop_uri.to_s)
  shop_supported_response = response
  puts shop_supported_response.body
  return shop_supported_response
end


def valid_user_token_exists
  body_text = @response.body
  body_text = body_text.to_s
  assert body_text.include? '"status":"success"'
  assert body_text.include? '"appId":46,"countryId":1,"token":"'
end


def get_user_token
  response = request_api_user_token
  return extract_user_token(response)
end



def get_data_from_request_crawl_on_product(product_url)
  crawl_results = request_crawl_on_product(@user_token, product_url)
  @parsed_response = parse_json(crawl_results.body)
  display_parsed_results(@parsed_response)
  return @parsed_response
end

def display_parsed_results(parsed_results)
  puts JSON.pretty_unparse(parsed_results)
end

def get_currency_info_from_response(response)
  product_json = get_value_from_json_for_key('product', response)
  price_json = get_value_from_json_for_key('price', product_json)
  return get_value_from_json_for_key('currency', price_json)
end
