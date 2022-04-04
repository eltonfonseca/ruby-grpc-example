# frozen_string_literal: true

require 'grpc'
require_relative '../autoload'
require 'product_controller'

class Server
  def initialize
    @port = '50051'
    @host = '0.0.0.0'
    @server = GRPC::RpcServer.new
  end

  def start
    puts "Starting GRPC Server on PORT: #{@port}"

    @server.add_http2_port("#{@host}:#{@port}", :this_port_is_insecure)
    @server.handle(ProductController)
    @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
  end
end
