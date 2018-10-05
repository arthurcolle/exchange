require 'socket'
require 'datetime'
require 'thread'
require 'net/http'
require 'websocket'

module ServerCallbacks
  class Connections()
    def f(session)

    end
  end

  class Orders()
    def f()
    end
  end

  class InternalServices()
    def f()
    end
  end

  class DecisionMaking()
    def f()
    end
  end

  class Rules()
    def f()
    end
  end
end

# Platform is an abstraction that maintains the ongoing existence of a bunch of
#  WebSocket servers. The details of their purpose follows, briefly outlining
#  the goal and intended function. For more, please see the documentation.
#
#  1. client connection interaction, handshaking &
#      any messaging related to the client talking
#      to the platform. (order state updates & any
#      client trading throttling are handled by a
#      different feed).
#  2. client order management and websocket feed
#      management services that provide dedicated
#      client websockets for trading-related
#      messaging vs. any kind of authentication,
#      re-authentication or other administrative
#      tasks. This helps to maximize throughput
#      through a single connection, vs. having
#      tons of disparate and unrelated messages
#      going through the same pipe.
#  3. internal services interaction, starting,
#      stopping the services as needed depending
#      on the outcomes of the mighty DecisionEngine()
#  4. the decision engine, which decides
#      what to do next if any blocking occurs.
#  5. the rules engine, which enables adding new "rules" on the
#      to the platform, disseminating updates in the form of simple message
#      updates to any of the other servers operating the platform.
#      This gives us the ability to modify their individual characteristics
#      when needed.
#      The intended goal is to give each server a set of traits that will be
#      modified depending on the system needs. Perhaps, in future versions of
#      this software, once the platform moves to a decentralized model after a
#      number of iterations, these very servers will have to run on nodes around
#      the world. When this occurs, it will be necessary for multiple exchange
#  6. dedicated feeds for the prop desk and special liquidity-providers,
#      and other trading partners.
#  7. advanced strategies engine - dark secrets for another time.

class ExchangeServer
  # tcp_server.rb
  def initialize(
    name, # label maps to server's function
    opts={
       type: :basic,
       host: host,
       port: port,
       functionality: behavior_callback
       max_connections: max_connections # max number of
    })

    @description = description
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

 def startWss(callback_args) do
   server = TCPServer.new @port
   while session = server.accept
     @functionality(session, callback_args)
   end
 end
end


class Client
    # tcp_server.rb
    def initialize(port, description)
      @host = '127.0.0.1'  # localhost
      @port = port  # must be set explicitly
      @create_datetime = datetime.datetime
      @activity_log = {}   # message_logs, maps
                           # their handle (username)
                           # to all the messages
                           # you've received in
                           # chronological order
    end

    def connect()
      http.g
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
    client_connections: ServerCallbacks::Connections::f,
    client_orders:      ServerCallbacks::Orders::f,
    propdesk_orders:    ServerCallbacks::NonStandardConnection::f   # dedicated feed for the prop desk. a la Coinbase
    internal_services:  ServerCallbacks::InternalServices::f
    decision_engine:    ServerCallbacks::DecisionEngine::f
    rules_engine:       ServerCallbacks::RulesEngine::f
    advanced_strategies: ServerCallbacks::AdvancedStrategies::f()
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
         :client_connections    => ExchangeServer(:client_connections, port: 3076 ).run(async: true),
         :client_orders         => ExchangeServer(:client_orders,      port: 3077 ).run(async: true),
         :services              => ExchangeServer(:internal_services,  port: 3079 ).run(async: true),
         :decisions             => ExchangeServer(:decision_engine,    port: 3080 ).run(async: true)
         :rules                 => ExchangeServer(:rules_engine,       port: 3081 ).run(async: true)
       }
      @supervisor = ExchangeServer(type: :supervisor)
  end
end
