class Change
  attr_reader :coins

  def initialize
    @coins = generate_coins
  end

  def release_coin(denomination, amount)
    coin_index = nil
    @coins.each_with_index do |coin, index|
      coin_index = index if coin.value == denomination
    end
    coin = @coins[coin_index]
    coin.release(amount)
  end

  private

  def generate_coins
    [
      Coin.new(1),
      Coin.new(2),
      Coin.new(5),
      Coin.new(10),
      Coin.new(20),
      Coin.new(50),
      Coin.new(100),
      Coin.new(200)
    ]
  end
end
