require 'socket'
require 'cbor'

  module Shortener
    class Server
      server = TCPServer.new 2000
      loop do
        Thread.start(server.accept) do |client|
          client.puts "Hello !"
          client.puts "Time is #{Time.now}"
          s = [1, 2, 33.5, 4].to_cbor  
          client.puts "Your message is #{s}"
          client.close
        end
      end
    end
  end
