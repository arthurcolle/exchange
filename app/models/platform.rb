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
      unit_interval = 1
      while (line = session.gets) && (line != "\r\n")
        http_request.push(str(counter))
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

# Platform is a key abstraction and provides the standard implementation for a
#   decentralized exchange. In principle, the only thing that restricts what
#   is being exchanged is that it must have a concrete implementation with
#   well-understood semantics or else no one will trade with
#   you. Right? I mean, why would they trade something with no value..?
#   Only an idiot would do that.
#   What is being exchanged doesn't matter - information, labor, or time. You
#   access the network by completing the handshaking protocol, and can use it in
#   view-only mode briefly before being perturbed by a modal.
#   In order to participate, you must build some momentum for yourself & tokenize.
#   Internally, the platform consists of a distributed system of networked hosts
#   that send messages back and forth, and trading all kinds of valuable commodities
#   of different kinds - any kind of information is fine.
#   Cryptocurrency, since it leads to other things, must not be based on the
#   existing blockchain designs, and must adopt a more radical design.
#   Initially your token might be worth zero. You don't know. But you can effect
#   it by paying for this predictability with bitcoin. Otherwise the value of
#   your token is set randomly. I think it makes sense to provide maximum
#   optionality. Different users have different needs, and others are interested
#   in taking some risk. Everyone wins here. The relative price to launch your
#   user momentum relative to bitcoin increases over time, with jumps to match
#   bitcoin's difficulty increases, to maintain a reasonable correspondence with
#   value over time and to ensure price stability.
#   To have your value increase with respect to the network fuel, 'time', you
#   have a few options:
#
#         Easy: other people swap their momentum for your momentum. The more momentum
#               you collect, the more time is available to you. And by diversifying
#               across different sources of momentum, you get a multiplicative effect
#               that compounds, with jumps.
#   Bit harder: help the network by running one or more origins (provides
#               network topology manifest to users that want to connect).
#       Medium: trading momentum based on listed public momentum feedback.
#
#   Everyone can see all the public feedback. Peer to peer feedback is a
#   critical element, not just network feedback based on your aggregated
#   behavior and whether you assist the network in functioning. Every message
#   must be accompanied with feedback in the form of a score. The network self-
#   assesses its performance by asking users for feedback once a day, and for
#   the most active users, the UX eventually asks them if they are interested in
#   providing feedback at a greater interval frequency. The score is out of 1024,
#   and the numerator can be any number from
#   2^{any integer from -10 to 10. This allows for any score between 0 and 1024}
#   Initially if you are the only one with an origin node, your host might be
#   overwhelmed with traffic. Relative to all past traffic, the amount of current
#   traffic you are handling and responding to determines your income rate, i.e.
#   the only thing the network wants is to continue to grow and exist, which it
#   does by heavily incentivizing users to maintain the network.
#   You are paid in time, which is the most valuable asset on the network.
#   If you ever run out of time your profile dies and have to create a new
#   handle. Your old handle will die along with you, forever. Really. "" will
#   become the only outgoing message that your node responds with, decreasing
#   their momentum (sad you're dead). People will definitely
#   connect to your node to access the network at the beginning since bootstrapping
#   a network is pretty hard, but market dynamics will sure start to slowly form.
#   In principle anything can be exchanged throughout the network, but the most
#   valuable thing to trade is
#   time, until your moment becomes pretty valuable.
#
#   Everyone has some kind of internal momentum and this is supposed to represent
#   that - what do celebrities and startups have that everyone else doesn't?
#   A platform and some momentum. Now everyone can try.
#
#   Practically speaking, at the moment only the time and moment abstractions
#   will be implemented upon the initial release. Others I'm thinking of are
#   omg (just text, positive feedback), msg (just text, no feedback), tax
#   (negative feedback unless you pay), wtf (negative feedback), exchange
#   (trading) and messaging hub.
#
#   Each client is encouraged to immediately launch their own individual tokens,
#   and the maintenance of their own blockchains is abstracted away from them,
#   to be able to merge all the message traffic and transaction data, along with
#   any of the more complex message types, into a consistent, uniform stream of
#   records.
#   This complexity comes at a cost to the person who has tokenized and now holds
#   a represents an abstraction for all their moments in time.
#   maintain their own blockchains ( the network abstracts away all the hard
#   parts of this ).
#   All of your realized future income in will then get partitioned evenly across
#   the stakeholders in your life, and you define the proportions if a uniform
#   distribution is not desired or acceptable given your circumstances.
#   Users define their own policy and set their own rules for what must be
#   achieved before further interaction is permitted.
#   People who have the biggest network will have the most likely chance at
#   having the value of their tokens rise as people trade each other's tokens
#   based on friendship, admiration. By associating individuals with their
#   perceived value, a completely new social dynamic would likely form.
#
#   The tokens could correspond to the value of their time, and I think there
#   would be a correspondence to future earnings in some way. This is an example
#   of emergent behavior as a consequence of juxtaposing everyone's perceptions
#   of value in a completely publicly accessible forum. How will this effect
#   jobs? How will this effect fiat currencies? Probably not at all for a long
#   time, but in due course, I'm sure that people's ideas about time and value,
#   and perhaps what they are spending their time on, will evolve.
#   Emerging phenomenon will cause fluctuations in the relative value of everyone's
#   time, as a function of the actions they take in the network. Are they producers
#   of content? Are they consumers? Do they keep a balanced approach, or do they
#   just do whatever?
#
#   There is an interesting experiment here if done with care. One key idea
#   here is that we're trying to make participating a totally frictionless flow
#   from one start to finish. Maybe you'll use this forever, maybe you will think
#   it's completely stupid. But if value is in the eye of the beholder, wouldn't
#   it be cool if you could get honest feedback from everyone you know all the
#   time?
#   Bitcoin is one implementation of something like this, where the time taken
#   to perform random computation is used to ensure that nodes are forced to
#   take time to do the proof of work "computational puzzle" where
#   an arbitrary scheme is used. What if we used non-random computation instead?
#   This is a bit grandiose but if the ultimate abstraction isn't money, then
#   what is it?
#
#   The platform maintains the ongoing persistence of at least three running
#   ExchangeServer objects, which can be configured from the default implementation
#   to be any kind of server you need it to be, by providing the constructor with
#   the protocol semantics. Details about this can be found in the documentation.
#   They are intended for maximum flexibility in their configurability.
#   Naturally, you must also implement the callbacks if you don't just use the
#   standard server implementation. Our server maintains two HTTP servers - one
#   for standard HTTP requests and another HTTP server to allow only WebSocket
#   connections and realtime messaging.
#   The types of messaging we'll be doing will require extremely fast throughput
#   and while the throughput on the HTTP server is expected to be much lower
#   given the potentially lower frequency of receiving a request (relative to a
#   realtime WebSocket feed), because of categorical difference, we give each
#   The first is to respond to, as needed, any incoming HTTP requests that are
#   received by the ES in question, with WebSocket requests managed entirely separately.

#  Note: Handling WebSockets using an HTTP server is perfectly fine to do, as
#   the protocol switching gives you this same facility, which requires following
#   the specific handshaking procedure (magic numbers & all). Once this is
#   accomplished, the entire operation is more or less handled by the client
#   implementing the protocol. The details of their purpose follow, & we briefly
#   outline the goal and intended function. For more, please see the
#   documentation.
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
#  KEEP UNTIL A DECISION HAS BEEN MADE.
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

 def startSubServers(callbackOpts={}) do
   s1( callbackOpts[:http] )
   s2( callbackOpts[:wss] )
 end

 # HTTP only server for non realtime messages.
 def s1(callback_opts) do
   server = TCPServer.new @host, @port
   while session = server.accept
     @implementation(session, callback_opts)
 end

 # WebSocket dedicated server to avoid having S1 perform any protocol switching.
 def s2(callback_opts) do
   server = TCPServer.new @port
   while session = server.accept
     @implementation(session.gets)
   end
 end
end


class Client
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
        :mon => "connection_request #{}",
        :tue => "connection_request Tue 000100",
        :web => "connection_request Wed 001000",
        :thu => "connection_request Thu 000010",
        :fri => "connection_request Fri 010000",
        :sat => "connection_request Sat 000001"
        :sun => "connection_request Sun 100000"
      }
    end

    defp conforms?(api_pubkey)
      :connected_request == connection_msg.decrypt(api_pubkey)
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
      if conforms?(api_pubkey) then
        Utils::generate_trading_token(Utils::identify_client(api_pubkey))
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

      # Supervisor doesn't do anything, just checks that uptime is > downtime
      # @supervisor = ExchangeServer(:supervisor, 6660)
  end

  def start
      @servers.each { |name,ref|
        ref.startSubServers()
      }
  end
end
