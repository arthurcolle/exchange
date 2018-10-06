require 'socket'

class Server()
  def __init__(self, server_numeric_id, server_shortname)
    @id = server_id
    @shortname = server_shortname
    keypair = Platform::API::Security.generateKeypair()
    @client = Platform::Client(mothership_connect: true)
    @ssh_private_key = keypair[ :private ]
     @ssh_public_key = keypair[ :public  ]

  end



class Client()
