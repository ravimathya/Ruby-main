require 'rubygems'
require 'httparty'
require 'uri'
require 'json'
require 'net/http'

code = "fe6f5d73f1455d91aeaccf851b975a74b248606b"

uri = URI.parse("https://api.github.com/user/repos")
header = {
    'Content-Type': 'text/json',
    'Authorization': "Bearer #{code}"
}

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Get.new(uri.request_uri, header)

response = http.request(request)
result = JSON.parse(response.body)
puts result