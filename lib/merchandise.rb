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
      Product.new('Cupcake', 90),
      Product.new('Donut', 80),
      Product.new('Eclair', 110),
      Product.new('Froyo', 110),
      Product.new('Gingerbread', 180),
      Product.new('Honeycomb', 10),
      Product.new('Ice Cream Sandwich', 180),
      Product.new('Jelly Bean', 150),
      Product.new('Kit Kat', 120),
      Product.new('Lollipop', 80),
      Product.new('Marshmallow', 100),
      Product.new('Nougat', 70),
      Product.new('Oreo', 160)
    ]
  end
end
