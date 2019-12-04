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
        start = UserOption.new.option(username)
    end
    

end

class UserOption
    # include ask
    def option(username)
        print "press 1 to show github repository \npress 2 ro create github repository: "
        option = gets.chomp.to_i
        puts "\n"
        if option == 1
            CreateAndReadRepository.new.read_repos(username)
        elsif option == 2
            CreateRepository.new.create_repos(username)
        else
            puts "Incorrect input"
        end
    end
end

class CreateAndReadRepository
    def create_repos(username)
        if FileReadWrite.new.read(username) == nil
            puts "enter your token:"
            access_token = gets.chomp
            FileReadWrite.write(username, access_token)
            puts CreateGithubRepository.new.create(username, access_token)
        else
            token = FileReadWrite.new.read(username)
            puts CreateGithubRepository.new.create(username, token)
        end
    end

    def read_repos(username)
        if FileReadWrite.new.read(username) == nil
            puts "enter your token:"
            access_token = gets.chomp
            FileReadWrite.write(username, access_token)
            puts ShowGithubRepository.new.show(access_token)
        else
            token = FileReadWrite.new.read(username)
            puts ShowGithubRepository.new.show(token)
        end
    end
end

# class ReadRepository
#     def read_repos(username)
#         if FileReadWrite.new.read(username) == nil
#             puts "enter your token:"
#             access_token = gets.chomp
#             FileReadWrite.write(username, access_token)
#             puts ShowGithubRepository.new.show(access_token)
#         else
#             token = FileReadWrite.new.read(username)
#             puts ShowGithubRepository.new.show(token)
#         end
#     end
# end

class FileReadWrite
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

    def write(username, token)
        file = File.open("code.txt", "a")
        file.puts "#{username} #{token}"
        file.close
    end
end

class ShowGithubRepository
    def show(token)
        uri = URI.parse("https://api.github.com/user/repos")
        header = {
            'Content-Type': 'text/json',
            'Authorization': "Bearer 3cb3f9c35ead4dff030788195151863a3cb8aa6a" 
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

class CreateGithubRepository
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