class Coin
  attr_reader :value, :quantity

  def initialize(value, quantity = 20)
    @value = value
    @quantity = quantity
  end
end
