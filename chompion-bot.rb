require 'cinch'
require 'uri'
require 'net/http'
require 'json'



class Chompion
  include Cinch::Plugin
  
  listen_to :channel
  
  def post(url, user)
    #post to the server
    http = Net::HTTP.new("127.0.0.1", 3000)
    
    request = Net::HTTP::Post.new('/links', initheader = {'Content-Type'=>'application/json'})
    request.set_form_data({"url"=>url, "user"=>user})
    response=http.request(request)
       
    
  end
  
  def listen(m)
    urls = URI.extract(m.message, "http")
    unless urls.empty?
      urls.each do |url|
        post(url, m.user.nick)
      end
    end

  end
  
end
bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#chompion"]
    c.plugins.plugins=[Chompion]
    c.nick = "chompion"
  end
end

bot.start