require 'rubygems'
require 'uri'
require 'json'
require 'net/http'



uri = URI.parse("https://api.twitter.com/1.1/statuses/update.json")
header = {
    'Content-Type': 'text/json',
    'Authorization': 
}