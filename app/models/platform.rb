require 'socket'
require 'datetime'
require 'socket'

# ExchangeServer class internally uses 3 separate TCP/IP servers for:
#  - client connection handshaking and any messaging
#  - internal services interaction
#  - worker task-routing and data processing/ decision_engine

class ExchangeServer
  # tcp_server.rb
  def initialize(self, opts = {:type => "basic", :host=>host, port: port}):
    @host = host  # localhost
    @port = port  # you have to set this explicitly
    @connected_clients = [] # list of pointers to client objects if the clients are connected locally or alternatively, they are references to RemoteClient clients or to RemoteClients
    @peers = []             # identified connected peers by id_number
    @create_datetime = datetime.datetime
    @activity_log = []               # message_logs, each a string.
    self.servers = {
      :clients  => []
      :services => []
    }
    @semaphore = Object.new
    @semaphore_available? = true
  end

  def connected_clients(with_info=false)
    count = 0
    @connected_clients.each {|client|
      count += 1
    }
    count
  end

 def run do
   server = TCPServer.new @port
   while session = server.accept
     session.puts "Server received a request.\nThe time is #{Time.now}"
     session.close
   end
 end
end


class Server
    # tcp_server.rb
    def initialize(port, description):
      @host = 'localhost'  # localhost
      @port = port  # you have to set this explicitly
      @create_datetime = datetime.datetime
      @activity_log = []               # message_logs, each a string.
    end
end

class Platform
  def initialize(mode)
    if    mode == "basic":
       @servers = [
         ExchangeServer(3077, description: :clients),
         ExchangeServer(3078, description: :services),
         ExchangeServer(3079, description: :decision_engine)
       ] # left: client-facing
                                                          # middle: services
                                                          # right: configuration
      @supervisor = Server(type: :supervisor)
  end
end
