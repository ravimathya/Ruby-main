require 'rubygems'
require 'httparty'
require 'uri'
require 'json'
require 'net/http'

uri = URI.parse("https://api.github.com/user/repos")
header = {
    'Content-Type': 'text/json',
    'Authorization': 'Bearer 5f3073ca5236fb1659266efd044fe6559add0739'
}
name = {name: 'epics', description: 'pushed from ruby rb' }

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = name.to_json

response = http.request(request)

