module Gemmmmy
  module Command
    def self.call(command, screen_name, argv)
      client = Gemmmmy::get_client(screen_name)
      response = client.send(command, *argv)

      prettifier = Gemmmmy::Prettifier.new(screen_name)
      prettifier.prettify!(response)
    end
  end
end
