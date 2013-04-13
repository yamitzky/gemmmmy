module Gemmmmy
  class Account
    require "yaml"

    attr_reader :screen_name
    attr_reader :oauth_token
    attr_reader :oauth_token_secret

    CONFIG = File.expand_path "../../../config.yml", __FILE__

    def initialize(screen_name)
      @screen_name = screen_name

      load_config!

      accounts = @config["accounts"]
      account = accounts[screen_name] if accounts

      unless account
        accounts.keys.each do |long_name|
          if long_name.start_with? screen_name
            screen_name = long_name
            account = accounts[screen_name] if accounts
            break
          end
        end
      end

      if account
        parse!(account)
      else
        puts "The account '#{screen_name}' was not found. Authorize!"
        authorize!
      end
    end

    def authorize!
      access_token = Gemmmmy::OAuth::get_access_token
      parse!(access_token.params)

      @config["accounts"] ||= {}
      params = {}
      %w(oauth_token oauth_token_secret).each do |attr|
        params[attr] = access_token.params[attr]
      end
      @config["accounts"][@screen_name] = params
      save_config!
    end

    def parse!(account)
      @oauth_token = account["oauth_token"]
      @oauth_token_secret = account["oauth_token_secret"]
      @screen_name = account["screen_name"] if account["screen_name"]
    end

    def load_config!
      unless File.exists? CONFIG
        file = File.open(CONFIG, "w")
        file.write("{}")
        file.close
      end

      @config = YAML.load_file CONFIG
    end

    def save_config!
      file = File.open CONFIG, "w"
      file.write(YAML.dump(@config))
      file.close
    end
  end
end
