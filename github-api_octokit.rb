require 'rubygems'
require 'httparty'
require 'octokit'

class EdutechionalResty
  include HTTParty
  base_uri "api.github.com"

  def posts
    # start for authentication github user
    client = Octokit::Client.new(:access_token => "5f3073ca5236fb1659266efd044fe6559add0739")

    user = client.user
    user.login    
    user.repo

    header = {}

    # self.class.get('/user/repos')
    # end for authentication github user
    # self.class.get('/5f3073ca5236fb1659266efd044fe6559add0739')
    # self.class.get ('/users/ravimathya/repos')
    #  auth = HTTParty.get('https://github.com/ravimathya/oauth/authorize')
    # self.class.post '/user/repos', body: { name: "blog", auto_init: true, private: false}
    
  end
end
api = EdutechionalResty.new
puts api.posts


# 5f3073ca5236fb1659266efd044fe6559add0739