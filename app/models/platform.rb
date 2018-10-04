require 'socket'
require 'datetime'

module ServerCallbacks
  class ClientConnectionManagement()
    def f
    end
  end

  class ClientOrderManagement()
    def f
    end
  end

  class InternalServices()
    def f
    end
  end

  class DecisionEngine()
    def f
    end
  end

  class RulesEngine()
    def f
    end
  end
end

# ExchangeServer class internally uses separate
# TCP/IP servers for:
#  - client connection interaction, namely handshaking and any messaging (order
#      state updates and any client throttling) - might need separate dedicated
#      client order management server that maintains a dedicated client websocket
#      in order to have a separate channel for trading-related order updates vs.
#      any kind of authentication, re-authentication or other administrative
#      tasks. This would be done to help maximize throughput through a single
#      connection, vs. having tons of disparate and unrelated messages going
#      through the same pipe
#  - internal services interaction, starting, stopping them as needed depending
#      on the outcome of the mighty DecisionEngine()
#  - the platform's decision engine, which decides what to do next if any blocking occurs for any reason (like what?)
#      the distributed system may be in.
#  - the platform's rules engine, which enables adding new "rules" on the fly to the platform
#  - worker task-routing and data processing/ decision_engine

class ExchangeServer
  # tcp_server.rb
  def initialize(
    description,
    opts={
       type: :basic,
       host: host,
       port: port,
       functionality_callback: behavior_callback
       max_connections: max_connections
    })

    @purpose = purpose
    @host = host || '127.0.0.1' # localhost
    @port = port # you have to set this explicitly
    @max_connection_count = max_connections
    @connected_clients = [] # list of pointers to client objects if the clients
                            # are connected locally through IPC or alternatively,
                            # they are references to RemoteClient clients or to
                            # RemoteClients identifiers that uniquely identify and have a correspondence with connected peers by id_number
    @peers = []
    @create_datetime = datetime.datetime
    @activity_log = []               # message_logs, each a string.
    @functionality = behavior_callback # behavior_callback is a reference to a method that must receive a session and callback_args conforming to the behavior_callback passed into the constructor upon instantiatiion of this class.
  end

  def connections(opts={with_info: false})
    count = 0
    @connected_clients.each {|client|
      count += 1
    }
    count
  end

 def run(opts={async: true}, callback_args) do
   server = TCPServer.new @port
   while session = server.accept
     @functionality_callback(session, callback_args)
   end
 end
end


class Client
    # tcp_server.rb
    def initialize(port, description):
      @host = '127.0.0.1'  # localhost
      @port = port  # you have to set this explicitly
      @create_datetime = datetime.datetime
      @activity_log = []               # message_logs, each a string.
    end
end

_______________________________________________________________________________
# server_behavior_mapping()
#
# Creates a mapping between label/description for given server subtype behavior
# implementation. The behavior callback that we will use to give all the Platform
# member ExchangeServers some life, and in turn, some purpose.
# Without purpose, we are nothing.
# Any additions should be implemented at the top of the this file with the others.
# This is done to keep the specification of the generic ExchangeServer() from
# any specific implementations. We want to give ourselves a blueprint so any
# future additions to the Platform's member servers' functionality,
# or the addition of any new server subtypes (with accompanying behavior
# implementations ). You MUST keep the implementation vs. specification of the
# ExchangeServers distinct. Don't fuck this up.
def server_behavior_mappings()
  {
    client_connections: ServerCallbacks::ClientConnectionManagement::f,
    client_orders:      ServerCallbacks::ClientOrderManagement::f,
    # propdesk_orders:    ServerCallbacks::PropDeskDedicatedOrderManagement::f   # dedicated feed for the prop desk. a la Coinbase

    # advanced_strategies: ServerCallbacks::AdvancedStrategies::f() {
    internal_services:  ServerCallbacks::InternalServices::f
    decision_engine:    ServerCallbacks::DecisionEngine::f
    rules_engine:       ServerCallbacks::RulesEngine::f
  }
end
_______________________________________________________________________________


class Platform
  def initialize(mode)
    if mode == nil || mode == :basic || mode == :default then
      supported_server_subtype_behaviors = server_behavior_mappings()
      supported_server_subtypes          = supported_server_subtype_behaviors.keys
      supported_server_behaviors         = supported_server_subtype_behaviors.values
      @server_references = {}
      supported_server_subtypes.each_with_index{ |subtype, index|
        @server_references[subtype] = @supported_server_subtype_behaviors[index]
      }
       @servers = {
         :client_connections => ExchangeServer(:client_connections, port: 3076 ).run(async: true),
         :client_orders      => ExchangeServer(:client_orders, port: 3077 ).run(async: true),
         :propdesk_orders    => ExchangeServer(:propdesk_orders, port: 3078 ).run(async: true),
         :services           => ExchangeServer(:internal_services,  port: 3079 ).run(async: true),
         :decisions          => ExchangeServer(:decision_engine,    port: 3080 ).run(async: true)
         :rules              => ExchangeServer(:rules_engine,       port: 3081 ).run(async: true)
       }
      @supervisor = ExchangeServer(type: :supervisor)
  end

  def
end
