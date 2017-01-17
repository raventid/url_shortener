require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative File.expand_path 'api/http/app.rb'

module RSpecMixin
  include Rack::Test::Methods

  def app
    LinkHandlerApp
  end

  RSpec.configure {|c| c.include RSpecMixin}
end
