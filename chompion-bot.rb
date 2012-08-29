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
  
  match /https?:\/\/[\S]+/
  
  def execute(m)
    #POST to the website
    url = URI.extract(m.message)
    debug "URL posted #{url}"
  end
end

class Hello
  match "hello"
  
  def execute(m)
    debug "#{m.user.nick} said hello"
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["##subreddit"]
    c.plugins.plugins=[Hello]
    c.nick = "chompion"
  end
end

bot.start