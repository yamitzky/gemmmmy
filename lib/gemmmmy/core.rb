module Gemmmmy
  CONSUMER_KEY = "qfwCf0MtF5wCbnKABRDsnw"
  CONSUMER_SECRET = "QQgB14NHB615KIoWxh6TYdXDxYXOWMvNi6mq7B3o"

  def self.get_client(screen_name)
    account = Account.new(screen_name)
    client = Twitter::Client.new(
      consumer_key: Gemmmmy::CONSUMER_KEY,
      consumer_secret: Gemmmmy::CONSUMER_SECRET,
      oauth_token: account.oauth_token,
      oauth_token_secret: account.oauth_token_secret
    )
    return client
  end
end
