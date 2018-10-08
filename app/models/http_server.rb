require 'socket'

module Platform
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
          p "[#{@label.to_s} #{@shortname.upcase}] received: #{data}"
        end
      end

      loop do
        data=(gets.hash) ** 2
        socket.print("Response: #{data}")
      end
    end
  end
end

def gs
  Platform::HttpServer.new(port: 5555, id: 0, name: "Alice", label: "server")
end
