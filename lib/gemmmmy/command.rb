module Gemmmmy
  module Command
    require "optparse"
    def self.call(argv)
      command = argv[0]
      argv = argv.slice(1, argv.length)

      screen_name = nil
      opt = OptionParser.new
      opt.on("--as VAL", "-a VAL") do |value|
        screen_name = value
      end
      argv = opt.parse(argv)

      client = Gemmmmy::get_client(screen_name)
      response = client.send(command, *argv)

      prettifier = Gemmmmy::Prettifier.new(screen_name)
      prettifier.prettify!(response)
    end
  end
end
