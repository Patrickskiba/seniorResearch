require 'twitter'
require 'daemons'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["twitter_consumer_key"]
  config.consumer_secret     = ENV["twitter_consumer_secret"]
  config.access_token        = ENV["twitter_access_token"]
  config.access_token_secret = ENV["twitter_access_token_secret"]
end

while false
  top_trending = client.trends.collect.first.name
  tweets = client.search("#{top_trending} -rt", lang: "en").take(15)
  tweets.collect { |tweet| client.follow tweet.user.screen_name;  sleep 250 }
end
