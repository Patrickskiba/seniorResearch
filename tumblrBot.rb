require 'tumblr_client'
require 'selenium-webdriver'
require 'headless'

Tumblr.configure do |config|
  config.consumer_key = ENV['tumblr_consumer_key']
  config.consumer_secret = ENV['tumblr_consumer_secret']
  config.oauth_token = ENV['tumblr_oauth_token']
  config.oauth_token_secret = ENV['tumblr_oauth_token_secret']
end

def trends
  headless = Headless.new
  headless.start
  driver = Selenium::WebDriver.for :firefox
  driver.navigate.to 'https://www.tumblr.com/explore/trending'
  trending = Array.new
  (1 ... 6).each{|x| trending.push driver.find_element(:css, "#posts > div > div > section.discover-tags > ol > li:nth-child(#{x}) > a > span").text}
  headless.destroy
  trending
end

while true
  client = Tumblr::Client.new
  search_results =  client.tagged(trends[rand(max=4)])
  blog_names = Array.new
  search_results.each_index { |results| blog_names.push search_results[results]['blog_name'] }
  blog_names.uniq.each{|name| client.follow name; print name; sleep 120 }
end

