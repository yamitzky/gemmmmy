require "twitter"

module Gemmmmy
  CONSUMER_KEY = "qfwCf0MtF5wCbnKABRDsnw"
  CONSUMER_SECRET = "QQgB14NHB615KIoWxh6TYdXDxYXOWMvNi6mq7B3o"
end

Twitter.configure do |config|
end

%w(oauth account).each do |lib|
  load File.expand_path("../gemmmmy/#{lib}.rb", __FILE__)
end
