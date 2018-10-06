require 'socket'

module Platform::Basics
  class HttpServer
    def initialize(opts={port: port, id: id, name: name, label: label})
      @id = id
      @label = label
      @shortname = server_shortname
      @host = '0.0.0.0'
      @port = port
      @tcpServer = TCPServer.new(@port)
      # keypair = Platform::API::Security.generateKeypair()
      # @client = Platform::Client(mothership_connect: true)
      # @ssh_private_key = keypair[ :private ]
      #  @ssh_public_key = keypair[ :public  ]
    end
  end
end
