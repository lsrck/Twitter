require 'twitter'
require "dotenv"
Dotenv.load

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
p $client
end

$client.update("Bonjour monde!")

def twitter_des_journalistes(*liste)
	liste.each {|journaliste| $client.update("#{journaliste} Je suis élève à The Hacking Projet une formation gratuite au code")}
end
twitter_des_journalistes("@thpnico", "@Fabien_971‏", "@Mamarieponpont")

def like_tweets(journaliste)
	tweets_id = $client.user_timeline(journaliste)
	tweets_id.each {|id| $client.favorite(id)}
end
like_tweets("@Mamarieponpont")

clientstream = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

topics = ["coffee","tea"]
clientstream.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
end