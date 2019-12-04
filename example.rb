require 'rubygems'
require 'uri'
require 'json'
require 'net/http'



# 3cb3f9c35ead4dff030788195151863a3cb8aa6a


# def file_read(name)
#     file = File.open("code.txt", "r+").each do |line|
#         words = line.split
#         if words[0] == name
#             token = words[1]
#             puts show(token)
#         else
#             puts "Enter your access token"
#             token = gets.chomp
#             file.puts "#{name} #{token}"
#             puts show(token)
            
#         end
#     end
#     file.close
# end
# def file_write(username, token)
#     file = File.open("code.txt", "a")
#     file.puts "#{username} #{token}"
#     file.close
#     puts "enter repository name: "
#     repo_name = gets.chomp
#     puts "enter description of repository:"
#     repo_description = gets.chomp
#     uri = URI.parse("https://api.github.com/user/repos")
#     header = {
#         'Content-Type': 'text/json',
#         'Authorization': "Bearer #{token}"
#     }
#     name = {name: "#{repo_name}", description: "#{repo_description}" }

#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true
#     request = Net::HTTP::Post.new(uri.request_uri, header)
#     request.body = name.to_json

#     response = http.request(request)
#     puts name
#     puts "https://www.github.com/#{username}/#{repo_name}"
#     # puts "your url is #{username} and code is #{token}."
# end

# puts "enter username: "
# username = gets.chomp
# # puts file_read(username)
# if file_read(username) == nil
#     puts "enter your token:"
#     access_token = gets.chomp
#     file_write(username, access_token)
# end
def show(token)
    uri = URI.parse("https://api.github.com/user/repos")
    header = {
        'Content-Type': 'text/json',
        'Authorization': "Bearer #{token}" 
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    response = http.request(request)
    result = JSON.parse(response.body)

end

def create(username, token)
    print "enter repository name: "
    repo_name = gets.chomp
    print "enter description of repository: "
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
    puts "URL of your new repository is https://github.com/#{username}/#{repo_name}.git"
    # https://github.com/ravimathya/awesome.git
    # puts "your url is #{username} and code is #{token}."
end

def file_write(username, token)
    file = File.open("code.txt", "a")
    file.puts "#{username} #{token}"
    file.close
    
end

def file_read(username)
    file = File.open("code.txt", "r").each do |line|
        words = line.split
        if words[0] == username
            token = words[1]
            return token 
        end
    end
    file.close
end

def read_repos()
    print "enter username: "
    username = gets.chomp
    if file_read(username) == nil
        puts "enter your token:"
        access_token = gets.chomp
        file_write(username, access_token)
        puts show(access_token)
    else
        token = file_read(username)
        puts show(token)
    end
end

def create_repos()
    print "enter username: "
    username = gets.chomp
    if file_read(username) == nil
        puts "enter your token:"
        access_token = gets.chomp
        file_write(username, access_token)
        puts create(username, access_token)
    else
        token = file_read(username)
        puts create(username, token)
    end
end

print "press 1 to show github repository and press 2 ro create github repository: "
option = gets.chomp.to_i
if option == 1
    read_repos()
elsif option == 2
    create_repos()
else
    puts "Incorrect input"
end


