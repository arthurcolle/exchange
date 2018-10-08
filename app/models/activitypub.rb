require 'net/http'
require 'websocket'
require 'json'

class Node
  def initialize(id, name, label, port) do
    @id = id
    @name = name
    @label = label
    @tcp_server = TCPServer.new 4321 if port!=nil
  end

  def run_server do
    loop do

    end
    client = @tcp_server.accept
    client.puts "Time: #{Time.now}"
    client.close
  end
  
  def handle_request
