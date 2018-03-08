require_relative './product'

class Merchandise
  attr_reader :products

  def initialize
    @products = generate_products
  end

  def release_product(index)
    product = @products[index]
    product.release
  end

  def reload_product(index, amount)
    product = @products[index]
    product.reload(amount)
  end

  private

  def generate_products
    [
      Product.new('Kit Kat', 90),
      Product.new('Dairy Milk', 80),
      Product.new('Walkers Salt and Vinegar Crisps', 110),
      Product.new('Walkers Cheese and Onion Crisps', 110),
      Product.new('Coke', 180),
      Product.new('Diet Coke', 180),
      Product.new('Pepsi', 150),
      Product.new('Diet Pepsi', 150)
    ]
  end
end
