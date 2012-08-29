require 'cinch'
require 'uri'
#bot = Cinch::Bot.new do
#  configure do |c|
#    c.server = "irc.freenode.org"
#    c.channels = ["##subreddit"]
#  end
#  
#  on :message, /https?:\/\/[\S]+/ do |m|
#    #POST to the website
#  end
#end
class Chompion
  include Cinch::Plugin
  match /https?:\/\/[\S]+/, method: :extract
  
  def post(url)
    #post to the server
  end
  
  def extract(m)
    urls = URI.extract(m.message, "http")
    unless urls.empty?
      m.reply "url: #{urls}"
    end

  end
  
end
bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["##subreddit"]
    c.plugins.plugins=[Chompion]
    c.nick = "chompion"
  end
end

bot.start