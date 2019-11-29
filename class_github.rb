require 'rubygems'
require 'uri'
require 'json'
require 'net/http'
require 'pry'

class Github
    new_line = "\n"
    attr_reader :username
    attr_reader :token
    def initialize(username)
      @username = username
    end

    def show(token)
        uri = URI.parse("https://api.github.com/user/repos")
        header = {
            'Content-Type': 'text/json',
            'Authorization': "Bearer 765c0e4348b2fa0cc71a72e2e7f96a86f8b6ee69" 
        }
    
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri, header)
    
        response = http.request(request)
        result = JSON.parse(response.body);nil
        result.each do |repo|
           puts repo['clone_url']
        end;nil
        
    
    end
    
    def create(username, token)
        print "enter repository name: "
        repo_name = gets.chomp
        print "enter description of repository: "
        repo_description = gets.chomp
        puts "\n"
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
        puts "git init"
        puts "git add ."
        puts 'git commit -m "first commit"'
        puts "git remote add origin https://github.com/#{username}/#{repo_name}.git"
        puts "git push -u origin master"
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
    
    def read_repos(username)
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
    
    def create_repos(username)
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
    
    def option
        print "press 1 to show github repository \npress 2 ro create github repository: "
        option = gets.chomp.to_i
        puts "\n"
        if option == 1
            read_repos(@username)
        elsif option == 2
            create_repos(@username)
        else
            puts "Incorrect input"
        end
    end
end

print "Enter username: "
username = gets.chomp
puts "\n"


git = Github.new("#{username}")
git.option




