require "twitter"

%w(oauth account command core ext prettifier).each do |lib|
  load File.expand_path("../gemmmmy/#{lib}.rb", __FILE__)
end
