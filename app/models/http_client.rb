require 'socket'
require 'date'

module Platform
  class HttpClient
    def initialize(port)
      @host = '127.0.0.1'
      @port = port
      @socket = TCPSocket.open(@host, @port)
    end

    def request(msg)
      Thread.new do
        loop do
	  p @socket.gets
        end
      end

      loop do
        @socket.sendmsg gets 
      end
    end
  end
end

def gc
  Platform::HttpClient.new(5555)
end
