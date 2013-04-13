module Gemmmmy
  module OAuth
    require "twitter_oauth"

    def self.get_access_token
      client = TwitterOAuth::Client.new(
        consumer_key: CONSUMER_KEY,
        consumer_secret: CONSUMER_SECRET
      )
      request_token = client.authentication_request_token(
        oauth_callback: "oob"
      )
      system "open #{request_token.authorize_url}"

      puts "Enter the PIN code:"
      code = gets.strip

      access_token = client.authorize(
        request_token.token,
        request_token.secret,
        oauth_verifier: code
      )

      return access_token
    end
  end
end
