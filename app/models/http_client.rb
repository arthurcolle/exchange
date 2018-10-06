require 'socket'

class HttpClient()
    def initialize(port) do
      @host = '127.0.0.1'
      @port = port
      @socket = TCPSocket.open(host, port)
    end

    def sendRequest(msg) do
      Thread.new do
        loop do
          data = socket.gets
          p data
        end
      end

      loop do
        data = gets
        socket.sendmsg data
      end
    end
end
