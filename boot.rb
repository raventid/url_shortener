require "byebug" if ENV["RACK_ENV"] == "development"
require "pry" if ENV["RACK_ENV"] == "development"

require_relative "url_shortener/container"

UrlShortener::Container.finalize! do |container|
  # Boot the app config before everything else
  container.boot! :config
end

require_relative "berg/persistence"

app_paths = Pathname(__FILE__).dirname.join("../apps").realpath.join("*")
Dir[app_paths].each do |f|
  require "#{f}/system/boot"
end

require_relative "berg/application"
