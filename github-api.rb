require 'rubygems'
require 'httparty'
require 'uri'
require 'json'
require 'net/http'

def file_read(name)
    file = File.open("code.txt", "r").each do |line|
        words = line.split
        if words[0] == name
            uri = URI.parse("https://api.github.com/user/repos")
            header = {
                'Content-Type': 'text/json',
                'Authorization': "Bearer #{words[1]}" 
            }

            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            request = Net::HTTP::Get.new(uri.request_uri, header)

            response = http.request(request)
            result = JSON.parse(response.body)
            return result
        end
    end
    file.close
end
def file_write(username, token)
    file = File.open("code.txt", "a")
    file.puts "#{username} #{token}"
    file.close
    puts "enter repository name: "
    repo_name = gets.chomp
    puts "enter description of repository:"
    repo_description = gets.chomp
    uri = URI.parse("https://api.github.com/user/repos")
    header = {
        'Content-Type': 'text/json',
        'Authorization': "Bearer #{token}"
    }
    name = {name: "#{repo_name}", description: "#{repo_description}" }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = name.to_json

    response = http.request(request)
    puts name
    puts "https://www.github.com/#{username}/#{repo_name}"
    # puts "your url is #{username} and code is #{token}."
end

puts "enter username: "
username = gets.chomp
puts file_read(username)
if file_read(username) == nil
    puts "enter your token:"
    access_token = gets.chomp
    file_write(username, access_token)
end