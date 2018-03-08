require 'coin'

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

  def insert_coin(denomination, amount)
    coin_index = nil
    @coins.each_with_index do |coin, index|
      coin_index = index if coin.value == denomination
    end
    coin = @coins[coin_index]
    coin.insert(amount)
  end

  def return_change(coins, price)
    total_inserted = coins.reduce(:+)
    change_due = total_inserted - price
    remainder = change_due
    change = []
    until change.reduce(:+) == change_due
      @coins.each do |coin|
        if coin.value <= remainder
          change << coin.value
          remainder -= coin.value
          release_coin(coin.value, 1)
          break
        end
      end
    end
    change
  end

  private

  def generate_coins
    [
      Coin.new(200),
      Coin.new(100),
      Coin.new(50),
      Coin.new(20),
      Coin.new(10),
      Coin.new(5),
      Coin.new(2),
      Coin.new(1)
    ]
  end
end
