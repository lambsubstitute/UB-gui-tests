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
  response = HTTParty.post(api_auth_host, :body => 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b'  )
  @response = response
  return @response
end

def request_crawl_on_product(user_token, product_url)
  api_prod_crawl_url = API_BASE + 'products/crawl'
  puts 'apiKey=' + user_token + ' url=' + product_url + ' wait:=true'
  response = HTTParty.post(api_prod_crawl_url, :body => 'apiKey=' + user_token + ' url=' + product_url + ' wait:=true'  )
  @crawl_response = response
  puts @crawl_response.body
  return @response
end

def extract_user_token(response)
  response_body = response.body.to_s
  token = response_body.match(/"token":".*scope/)
  token = token.to_s.gsub('"token":"', '').gsub('","scope', '')
  puts 'extracted user token'
  puts token
  return token
end

When(/^I request pre crawl on the product url "([^"]*)"$/) do |arg|
  request_crawl_on_product(@user_token, arg)
end

Then(/^I should receive the data:$/) do |table|
  # table is a table.hashes.keys # => []
  pending
end