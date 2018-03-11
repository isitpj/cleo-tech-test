require_relative './coin'

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
    change_due = sum(coins) - price
    remainder = change_due
    find_correct_change(change_due, price, remainder)
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

  def sum(coins)
    coins.reduce(:+)
  end

  def find_correct_change(change_due, price, remainder)
    change = []
    until sum(change) == change_due
      @coins.each do |coin|
        if coin.value <= remainder && coin.quantity > 0
          change, remainder = update_remainder_and_release(coin, remainder, change)
          break
        end
      end
    end
    change
  end

  def update_remainder_and_release(coin, remainder, change)
    change << coin.value if coin.quantity > 0
    remainder -= coin.value
    release_coin(coin.value, 1)
    return change, remainder
  end
end
