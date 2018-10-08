module Basic
  class Order
    attr_accessor :client
    def initialize(product, type, price, size, secure_session_token)
      @client = Client.lookup_by(session_token: secure_session_token)
      @creation_datetime = Time.now
      # by virtue of being either nil or true depending on the new order to be constructed from
      # the parameters corresponding to what the value of the second argument, 'type', which
      # can be either atom :bid or :offer
      if type == :bid then @bidside = true elsif type == :offer then @offerside = true end
    end

  def bidside?
    # we do this instead of returning the quantity directly in order to constrain
    # the acceptable domain of values to only either true or falwe
    if @bidside && @offerside then raise ArgumentError "can't have both be true, and cant have them both not exist" end
    if @bidside == true return true end
    if @offerside == true return false end
end

class ServiceFactory()
  def initialize(opts = {intended_purpose: intended_purpose}, functionality_callback)
    if opts[:intended_purpose] == nil then
      @intended_purpose = :unknown
      raise ArgumentError "What is my purpose? <pass butter>"
    else @service_functionality = functionality_callback end
  end

  defp construct_service_from_behavior()
  end
end

class

class MatchingEngine()
  # One of the internal services is the OrderBook service which keeps track of
  # the live market state of the orderbook, i.e. all the current bids and offers
  # that are live on the exchange.
  # ClientManagementExchangeServer()
  # MatchingEngineExchangeServer receives a consolidated payload with every heartbeat message between the
  # internal services ExchangeServer and attempts to find any crosses.
  # If crosses are found, that represents the
  # aggregation of any and all new
  # orders, along with upsizes to existing orders, and of course, any cancellations of existing orders.
  # It does not process any client requests nor does it have any interaction
  # with any clients connected to the platform - this is by design as we want
  # all exchange functionality to be hidden from users other than interaction
  # with the platform API.
  # the client_interaction ExchangeServer processes updates from connected
  # clients through one of the available network
  # websocket connections used to manage inbound and outgoing traffic that includes
  # market state updates.

  # Updates include order cancellations, new orders, upsizes to existing orders.
  # Instead of new orders being given their own identity, we simplify our order entry model by
  #
  defp supported_products_index() do :generic_cryptoasset end

  def initialize(product, direction, )
    @supported_products = supported_products_index()
    @valid_product = @supported_products.intersect(product)
    @unfilled = {
      bids: [ # this has all the individual bids and same for below with offers
        # Order(:bid, size: size, price: price)
      ],
      offers: [
        # Order(:offer, size: size, price: price)
      ]}
     @consolidated_market_state = {
       bids: [
        # {order_id: Utils::OrderLifecycle.order(
        #   token: token,
        #   direction:
        #   ], 
       offers: []
     }

    @log = []
    @speedbump = :off
    @mid = (max(@market_state[:bids]) + min(@market_state[:offers]))/2
  end

  def test_orders(number, spread, opts={})
  def
