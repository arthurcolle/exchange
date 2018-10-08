module Platform do
  class Client
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

      def magicNumber(input)
      end

      def authenticated? return authenticated end

      def todays_msg(day_atom) do
        dayIndex =
             #=================================================================
             # 0     1     2     3     4     5     6       DateTime.now.cwday
          [
            :sun, :mon, :tue, :wed, :thu, :fri, :sat
          ]

        days =
          {
            sun: "Sunday",
            mon: "Monday",
            tue: "Tuesday",
            wed: "Wednesday",
            thu: "Thursday",
            fri: "Friday",
            sat: "Saturday"
          ]

        if daysIndex[DateTime.now.cwday] then do
          return "{msg: 'connection_request', day: '#{daysIndex[DateTime.now.cwday]}', magicNumber: '#{Platform::API.magicNumber()}'}" end

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
          Platform::Client::generate_trading_token(Platform::API::identify_client(api_pubkey))
        else
        if authenticated?
          if @activity_log[]
        else
          Net::HTTP.get(@host + ":" + @port + "/api/v1/authenticate?id=")
      end
  end

end
