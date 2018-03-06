require 'merchandise'
require 'change'

class Machine
  VALID_DENOMINATIONS = [200, 100, 50, 20, 10, 5, 2, 1]
  attr_reader :merchandise, :change, :user_selection

  def initialize
    @merchandise = Merchandise.new
    @change = Change.new
    @user_selection = nil
  end

  def print_products
    @merchandise.products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name}. Price: #{product.price}"
    end
    puts 'Please enter \'reload\' to add more products or change to the machine.'
  end

  def process_user_selection
    @user_selection = STDIN.gets.chomp.to_i - 1
    product_name = @merchandise.products[@user_selection].name
    product_price = @merchandise.products[@user_selection].price
    STDOUT.puts "A #{product_name} costs #{product_price}p. Please insert coins."
  end

  def accept_coins(price)
    coins = []
    coins = get_coins(coins, price)
    coins.each { |coin| @change.insert_coin(coin, 1) }
    total_inserted = coins.reduce(:+)
    if total_inserted > price
      get_change(total_inserted, price)
    else
      coins
    end
  end

  private

  def get_coins(coins, price)
    inserted_amount = 0
    while inserted_amount < price
      inserted_coin = STDIN.gets.chomp.to_i
      if VALID_DENOMINATIONS.include?(inserted_coin)
        coins << inserted_coin
        inserted_amount += inserted_coin
      else
        STDOUT.puts 'Sorry, that is not a valid denomination.'
      end
    end
    coins
  end

  def get_change(total_inserted, price)
    change_due = total_inserted - price
    change = []
    remainder = change_due
    until change.reduce(:+) == change_due do
      @change.coins.each do |coin|
        if coin.value <= remainder
          change << coin.value
          remainder -= coin.value
          @change.release_coin(coin.value, 1)
          break
        end
      end
    end
    return change
  end
end
