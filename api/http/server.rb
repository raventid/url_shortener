#require_relative 'import'
require_relative 'config'
require_relative 'app'

EM.run do
  server = 'thin'
  host = '0.0.0.0'
  port =  '4000'
  app = App.new

  dispatch = Rack::Builder.app do
    map '/' do
      run app
    end
  end

  Rack::Server.start({
    app: dispatch,
    server: server,
    Host: host,
    Port: port,
    signals: false
  })
end
