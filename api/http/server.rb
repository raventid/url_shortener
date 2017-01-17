require 'eventmachine'

EM.run do
  require_relative 'dependencies'
  require_relative 'app'

  DEFAULT = {
    server: 'thin',
    host: '0.0.0.0',
    port: '4000',
  }

  server = DEFAULT[:server] 
  host = DEFAULT[:host] 
  port = DEFAULT[:port] 
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
