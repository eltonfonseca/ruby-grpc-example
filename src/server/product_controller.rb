# frozen_string_literal: true

require 'product_services_pb'
require 'memory'
require 'product'

class ProductController < ProductContract::Actions::Service
  def create_product(request, _)
    product = Product.new(
      name: request.name,
      category: request.category,
      price: request.price,
      quantity: request.quantity
    )

    create_response(Memory.add(product))
  end

  def get_product(request, _)
    product = Memory.get(request.id)
    return emtpy_response if product.nil?

    get_response(product)
  end

  def list_products(_, _)
    products = Memory.all

    list_response(products)
  end

  def delete_product(request, _)
    Memory.remove(request.id)

    ProductContract::DeleteResponse.new(
      status: status_code(204)
    )
  end

  private

  def create_response(id)
    ProductContract::CreateResponse.new(
      status: status_code(201),
      id:
    )
  end

  def emtpy_response
    ProductContract::GetResponse.new(
      status: status_code(404),
      payload: ProductContract::Payload.new
    )
  end

  def get_response(product)
    ProductContract::GetResponse.new(
      status: status_code(200),
      payload: payload(product)
    )
  end

  def list_response(products)
    ProductContract::ListResponse.new(
      status: status_code(200),
      payload: products ? products.map { |product| payload(product) } : []
    )
  end

  def payload(product)
    ProductContract::Payload.new(
      id: product[:id],
      name: product[:object].name,
      category: product[:object].category,
      price: product[:object].price,
      quantity: product[:object].quantity
    )
  end

  def status_code(code)
    ProductContract::StatusCode.new(code:)
  end
end
