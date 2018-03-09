require_relative './printer'
require_relative './merchandise'
require_relative './change'

class Dispense
  VALID_DENOMINATIONS = [200, 100, 50, 20, 10, 5, 2, 1]
  attr_reader :printer, :selection, :merchandise, :change, :change_due

  def initialize(selection, merchandise, change)
    @printer = Printer.new
    @selection = selection
    @merchandise = merchandise
    @change = change
    @change_due = nil
  end

  def dispense
    price = @merchandise.products[@selection].price
    accept_coins(price)
    return_product
    return_change
  end

  def accept_coins(price)
    coins = get_coins(price)
    coins.each { |coin| @change.insert_coin(coin, 1) }
    @change_due = @change.return_change(coins, price) if sum(coins) > price
  end

  def return_product
    product = @merchandise.products[@selection]
    @selection = nil
    @printer.print_return_product(product)
  end

  def return_change
    change = @change_due
    @change_due = nil
    @printer.print_return_change(change) unless change.nil?
  end

  private

  def get_coins(price)
    coins = [0]
    while sum(coins) < price
      inserted_coin = receive_coin
      coins << inserted_coin if valid_coin?(inserted_coin)
    end
    coins.drop(1)
  end

  def sum(array)
    array.reduce(:+)
  end

  def valid_coin?(inserted_coin)
    VALID_DENOMINATIONS.include?(inserted_coin) ? true : @printer.invalid_coin_inserted
  end

  def receive_coin
    @printer.request_coins
    STDIN.gets.chomp.to_i
  end
end
