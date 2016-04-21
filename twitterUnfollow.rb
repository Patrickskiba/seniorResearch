require 'twitter'
require 'json'
require 'daemons'
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["twitter_consumer_key"]
  config.consumer_secret     = ENV["twitter_consumer_secret"]
  config.access_token        = ENV["twitter_access_token"]
  config.access_token_secret = ENV["twitter_access_token_secret"]
end

text = File.read('output.json')
hashed = JSON.parse(text)
@list = hashed
while @list.length > 1
  one = hashed[0]
  @list = hashed
  client.unfollow(one)
  @list.delete(one)
  jsoned = JSON.dump(@list)
  File.open('output.json', 'w') { |hash| hash.write(jsoned) }
  sleep 250
end




