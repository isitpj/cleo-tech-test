class Product

  attr_reader :name, :price, :quantity

  def initialize(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
  end

  def release
    @quantity -= 1
  end
end
