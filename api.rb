require 'rubygems'
require 'httparty'
require 'uri'
require 'json'
require 'net/http'

class EdutechionalResty
  include HTTParty
  base_uri "api.github.com"

  def posts
    uri = URI.parse("api.github.com")
    header = {'Content-Type': 'text/json'}
    user = {user: {
        username: 'ravimathya',
        password: 'Blueheart9899'
        }
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)
    request.body = user.to_json

    response = http.request(request)

  end
end
api = EdutechionalResty.new
puts api.posts
