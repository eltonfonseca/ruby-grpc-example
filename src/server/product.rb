# frozen_string_literal: true

class Product
  attr_accessor :name, :category, :price, :quantity

  def initialize(name:, category:, price:, quantity:)
    @name = name
    @category = category
    @price = price
    @quantity = quantity
  end
end
