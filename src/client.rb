# frozen_string_literal: true

require_relative './autoload'

require 'grpc'
require 'product_services_pb'

# @Client main client
class Client
  attr_accessor :server

  def initialize
    hostname = 'localhost:50051'
    @server = ProductContract::Actions::Stub.new(hostname, :this_channel_is_insecure)
    puts "Connected on #{hostname}"
  end

  def create
    puts 'Creating product ...'
    message = @server.create_product(product)
    puts "Product ID: #{message.id}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end

  def find(id)
    product = @server.get_product(ProductContract::GetOrDeleteRequest.new(id:))
    return 'Product not found' if product.status.code == 404

    show_product(product.payload)
  end

  def list
    products = @server.list_products(ProductContract::Empty.new)
    return [] if products.payload.empty?

    products.payload.each { |product| show_product(product) }
  end

  def delete(id)
    response = @server.delete_product(ProductContract::GetOrDeleteRequest.new(id:))

    return 'Deleted Success!' if response.status.code == 204

    'Error on delete'
  end

  private

  def product
    ProductContract::CreateRequest.new(
      name: 'Bravecto',
      category: 'Remédios',
      price: 14.50,
      quantity: 15
    )
  end

  def show_product(product)
    puts "ID: #{product.id}"
    puts "Name: #{product.name}"
    puts "Category: #{product.category}"
    puts "Price: #{product.price}"
    puts "Quantity: #{product.quantity}"
  end
end
