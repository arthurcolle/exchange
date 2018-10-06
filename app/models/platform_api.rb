module Platform::API
  class Public

  end



  class Private
    def initialize(goodmorning, admin_pub_key) do
      @authenticated? = Platform::Security.decrypt(goodmorning, admin_pub_key)
    end

    def tunnel do
      if @authenticated? then do
        Platform::API.connect(Platform::API.findRelay())
      end
    end
  end
end
