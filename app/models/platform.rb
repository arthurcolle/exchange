require 'socket'
require 'datetime'
require 'thread'
require 'net/http'
require 'websocket'
require 'direct/sha1'

module ServerCallbacks
  class Connections
    def f(session)
      http_request = ""
      counter = 0
      while (line = session.gets) && (line != "\r\n")
        http_request.push(str(counter))
        counter += 5
        http_request.push(str(counter))
        http_request.push("\n")
        http_request += line
      end
    end
    return session.write http_request
  end

  class Orders
    def f()
    end
  end

  class Services
    def f()
    end
  end

  # class DecisionMaking
  #   def f()
  #   end
  # end
  #
  # class Rules
  #   def f()
  #   end
  # end
end

# Platform is an abstraction that maintains the ongoing existence of
#   at least three ExchangeServers, which are generic and configurable in what
#   they can do - you implement the callback that implements the desired set of
#   functionalities, and then an HTTP server and a separate WebSocket server are
#   created to respond to HTTP requests, and exist as references maintained by
#   the ExchangeServer abstraction. All HTTP requests are then handled by the
#   dedicated HTTP server, while any WebSocket messages are handled by the WSServer.
#   These are not important to the user per se, but the devil is in the details.
#
#  Note: Handling WebSockets using an HTTP server is perfectly fine to do, as
#   the protocol switching gives you this same facility, which requires following
#   the specific handshaking procedure (magic numbers & all). Once this is
#   accomplished, the entire operation is more or less handled by the protocol.
#   The details of their purpose follow, & we briefly outline the goal and
#   intended function. For more, please see the documentation.
#
#  1. client connection interaction, handshaking &
#      any messaging related to the client talking
#      to the platform. (order state updates & any
#      client trading throttling are handled by a
#      different feed, but to the client, its a different method through
#      the web API, provided through a RESTful API).
#  2. client order management and websocket feed
#      management services that provide dedicated
#      client websocket messaging for trading-related
#      messaging vs. any kind of authentication,
#      re-authentication or other administrative
#      tasks. This helps to maximize throughput
#      through a single connection, & helps to avoid having
#      too many different kinds of disparate and unrelated messages
#      going through the same websocket.
#  3. internal services interaction, starting,
#      stopping the services as needed depending
#      on the outcomes of the mighty DecisionEngine()
#
#  The following are commented out in the implementation, as I suspect it may
#     be a better idea to pursue simplicity in the design rather than having so
#     many different services. With a dedicated internal services messaging server
#     and two dedicated feeds for trading-messaging and for client-connection mgmt
#     we're probably already where we need to be.
#
#  KEEP UNTIL A DECISION HAS BEEN MADE. Thanks. AMC
#
#  4. the decision engine, which decides
#      what to do next if any blocking occurs (trading decisions to make sure
#      liquidity on the platform's exchange.
#  5. the rules engine, which enables adding new "rules" on the
#      platform, disseminating updates in the form of simple message
#      updates to any of the other servers operating the platform.
#      This gives us the ability to modify their individual characteristics
#      when needed.
#      The intended goal is to give each server a set of traits that will be
#      modified depending on the system needs. Perhaps, in future versions of
#      this software, once the platform moves to a decentralized model after a
#      number of iterations, these very servers will have to run on nodes around
#      the world. When this occurs, it will be necessary for multiple exchange
#      instances to exist in order to scale the usage to millions of concurrent
#      users
#  6. dedicated feeds for the prop desk and special liquidity-providers
#  7. advanced strategies engine - dark secrets for another time.

class ExchangeServer
  def initialize(
    name, # label maps to server's function
    opts={
       type: :basic,
       host: host,
       port: port,
       implementation: behavior_callback
       max_connections: max_connections
    })

    @description = description
    @host = host || '127.0.0.1' # localhost
    @port = port # you have to set this explicitly
    @max_connection_count = max_connections
    @connected_clients = {} # maps token to a pointer
    @peers = []
    @create_datetime = time.ctime()
    @activity_log = []               # message_logs, each a string.
    @implementation = behavior_callback # behavior_callback is a reference to a method that must receive a session and callback_args conforming to the behavior_callback passed into the constructor upon instantiatiion of this class.
  end

  def connections(opts={with_info: false})
    count = 0
    @connected_clients.each {|client| count += 1 }
    count
  end

 def startHttpServer(callback_opts) do
   server = TCPServer.new @host, @port
   while session = server.accept
     @implementation(session, callback_opts)
 end

 def startServer(callback_opts) do
   server = TCPServer.new @port
   while session = server.accept
     @implementation(session.gets)
   end
 end
end


class PlatformClient
    # tcp_server.rb
    def initialize(port, description, environment=:development)
      @host = "localhost"  # localhost
      @port = port  # must be set explicitly
      if environment == :development then
        @platform_port = "6670"
      elsif environment == :production then
        @platform_port = "80"
      else
        raise ArgumentError, "unacceptable environment type.\nPlease use :development or :production."
      end
      @platform_host = "0.0.0.0"

      @creation_datetime = time.ctime()
      @activity_log = {}   # message_logs, maps
                           # their handle (username)
                           # to all the messages
                           # you've received in
                           # chronological order
      @authenticated = false
    end
    def authenticated? return authenticated end

    def todays_msg(day_atom) do
      {
        :mon => "connection_request Mon 000000",
        :tue => "connection_request Tue 000100",
        :web => "connection_request Wed 001000",
        :thu => "connection_request Thu 000010",
        :fri => "connection_request Fri 010000",
        :sat => "connection_request Sat 000001"
        :sun => "connection_request Sun 100000"
      }
    end
    def connect(connection_msg, api_pubkey, environment=:development)
      # we expect the connection_msg argument to consist of the message
      # "connection_request" signed by ones private key. You then give me your
      # public API key, which I can use to decrypt the message in the backend.
      # If the message str matches "connection_request"
      # then I proceed, returning a hex token that you can then use for 2 hours
      # before your websocket connection to the trading engine
      # gets disconnected. this token is then to be used as one of the message
      # payload keys, with every message payload.
      if connection_msg.decrypt(api_pubkey)=="connection_request" then
        return Utils::generate_trading_token(Utils::identify_client(api_pubkey))
      else
      if authenticated?
        if @activity_log[]
      else
        Net::HTTP.get(@host + ":" + @port + "/api/v1/authenticate?id=")
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
# implementations ). MUST keep the implementation vs. specification of the
# ExchangeServers distinct.
def server_behavior_mappings()
  {
    connections: ServerCallbacks::Connections::f,
    orders:      ServerCallbacks::Orders::f,
    services:    ServerCallbacks::Services::f
    # decision_engine:    ServerCallbacks::DecisionEngine::f
    # rules_engine:       ServerCallbacks::RulesEngine::f
    # advanced_strategies: ServerCallbacks::AdvancedStrategies::f
  }
end
_______________________________________________________________________________


class Platform
  def initialize(mode)
    if mode == nil || mode == :basic || mode == :default then
      supported_server_subtype_behaviors = server_behavior_mappings()
      supported_server_subtypes          = supported_server_subtype_behaviors.keys
      supported_server_behaviors         = supported_server_subtype_behaviors.values
      @server_references = {}     # label -> reference.
      supported_server_subtypes.each_with_index{ |subtype, index|
        @server_references[subtype] = @supported_server_subtype_behaviors[index]
      }
      @servers = {
        :connections    => ExchangeServer(:client_connections, port: 3076 ),
        :orders         => ExchangeServer(:client_orders,      port: 3077 ),
        :services       => ExchangeServer(:internal_services,  port: 3079 )
        # :decisions      => ExchangeServer(:decision_engine,    port: 3080 )
        # :rules          => ExchangeServer(:rules_engine,       port: 3081 )
       }
       # @supervisor = ExchangeServer(:supervisor, 6660)
  end

  def start
      @servers.each { |name,ref|
        ref.startServers()
      }
  end
end
