require 'socket'
require 'date'

class Platform
  class HttpClient
    def initialize(port)
      @host = '127.0.0.1'
      @port = port
      @socket = TCPSocket.open(@host, @port)
    end

    def request(msg)
      Thread.new do
        loop do
          data = @socket.gets
          p data
        end
      end

      loop do
        data = gets
        @socket.sendmsg data
      end
    end
  end

  class HttpServer
    def initialize(port: port, id: id, name: name, label: label)
      @id = id
      @label = label
      @shortname = name
      @host = '0.0.0.0'
      @port = port
      @tcpServer = TCPServer.new(@port)
      # keypair = Platform::API::Security.generateKeypair()
      # @client = Platform::Client(mothership_connect: true)
      # @ssh_private_key = keypair[ :private ]
      #  @ssh_public_key = keypair[ :public  ]
    end

    def go
      socket = @tcpServer.accept
      Thread.new do
        loop do
          data = socket.gets
          p "[#{label.to_s}] #{shortname.upcase} received: #{data}"

        end
      end

      loop do
        data=gets
        socket.print("Response: #{data}")
      end
    end
  end
end


def getRunServer
  server=Platform::HttpServer.new(port: 5555, id: 0, name: "Alice", label: "server")
  server.go
end

def getClient
  client=Platform::HttpClient.new(5555)
end

require_relative 'http_client'
xc=getClient()
