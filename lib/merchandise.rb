require 'product'

class Merchandise

  attr_reader :products

  def initialize
    @products = generate_products
  end

  private

  def generate_products
    [
      Product.new('Kit Kat', 90, 10),
      Product.new('Daiy Milk', 80, 10),
      Product.new('Walkers Salt and Vinegar Crisps', 110, 10),
      Product.new('Walkers Cheese and Onion Crisps', 110, 10),
      Product.new('Coke', 180, 10),
      Product.new('Diet Coke', 180, 10),
      Product.new('Pepsi', 150, 10),
      Product.new('Diet Pepsi', 150, 10)
    ]
  end

end
