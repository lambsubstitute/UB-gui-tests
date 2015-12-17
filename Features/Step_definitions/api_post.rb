#require 'net/http'#

#require 'rubygems'
#require 'json'

#@user = 'user@socialtext.com'
#@pass = 'password'
#@host = 'pitchblende.socialtext.net'
#response = HTTParty.post(api_auth_host, :body => 'apiKey=11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b'  )


#@post_ws = "/data/workspaces"#

#@payload ={
#    "apiKey" => "11c91508603f7e2f117e5bcdaa97b16029c2a3d24205926b097b03b47604d726773b2e0f9440180b7e7cfdf17d8903b93b32301fe2503371b8e6aeadf4e14d8b"
#}.to_json

#def post
 # req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' =>'application/json'})
  #req.basic_auth @user, @pass
 # req.body = @payload
 # response = Net::HTTP.new(@host).start {|http| http.request(req) }
 # puts "Response #{response.code} #{response.message}:
 # #{response.body}"
#end

#thepost = post
#puts thepost