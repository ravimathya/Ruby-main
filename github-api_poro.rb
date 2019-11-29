require 'rubygems'
require 'uri'
require 'json'
require 'net/http'

# module ask
#     print "enter username: "
#     username = gets.chomp
# end

class Github
    attr_reader :username
    def initialize(username)
      @username = username
    end

    def first
        start = User_Option.new.option(username)
    end
    

end

class User_Option
    # include ask
    def option(username)
        print "press 1 to show github repository \npress 2 ro create github repository: "
        option = gets.chomp.to_i
        puts "\n"
        if option == 1
            Read_repository.new.read_repos(username)
        elsif option == 2
            Create_Repository.new.create_repos(username)
        else
            puts "Incorrect input"
        end
    end
end

class Create_Repository
    def create_repos(username)
        if File_Read.new.read(username) == nil
            puts "enter your token:"
            access_token = gets.chomp
            File_Write.write(username, access_token)
            puts Create_Github_Repository.new.create(username, access_token)
        else
            token = File_Read.new.read(username)
            puts Create_Github_Repository.new.create(username, token)
        end
    end
end

class Read_repository
    def read_repos(username)
        if File_Read.new.read(username) == nil
            puts "enter your token:"
            access_token = gets.chomp
            File_Write.write(username, access_token)
            puts Show_Github_Repository.new.show(access_token)
        else
            token = File_Read.new.read(username)
            puts Show_Github_Repository.new.show(token)
        end
    end
end

class File_Read
    def read(username)
        file = File.open("code.txt", "r").each do |line|
            words = line.split
            if words[0] == username
                token = words[1]
                return token 
            end
        end
        file.close
    end    
end

class File_Write
    def write(username, token)
        file = File.open("code.txt", "a")
        file.puts "#{username} #{token}"
        file.close
    end
end

class Show_Github_Repository
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
           puts repo['ssh_url']
        end;nil
    end
end

class Create_Github_Repository
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
        result = JSON.parse(response.body)

        puts response['ssh_url']
        puts "git init"
        puts "git add ."
        puts 'git commit -m "first commit"'
        puts "git remote add origin https://github.com/#{username}/#{repo_name}.git"
        puts "git push -u origin master"
        # https://github.com/ravimathya/awesome.git
        # puts "your url is #{username} and code is #{token}."
    end
end

print "Enter username: "
username = gets.chomp
puts "\n"

git = Github.new("#{username}")
git.first()