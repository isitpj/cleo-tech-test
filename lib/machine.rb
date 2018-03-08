require 'merchandise'
require 'change'
require 'printer'

class Machine
  VALID_DENOMINATIONS = [200, 100, 50, 20, 10, 5, 2, 1]
  attr_reader :merchandise, :change, :printer, :user_selection, :change_due

  def initialize
    @merchandise = Merchandise.new
    @change = Change.new
    @printer = Printer.new
    @user_selection = nil
    @change_due = nil
  end

  def display_menu
    @printer.print_product_selection(@merchandise)
    @printer.print_reload_option
  end

  def assign_user_selection
    input = STDIN.gets.chomp.downcase
    input == 'reload' ? @user_selection = input : @user_selection = input.to_i - 1
  end

  def process_user_selection
    print_product if @user_selection.class == Integer
    print_reload_options if @user_selection == 'reload'
  end

  def accept_coins(price)
    coins = get_coins(price)
    coins.each { |coin| @change.insert_coin(coin, 1) }
    @change_due = @change.return_change(coins, price) if sum(coins) > price
  end

  def get_reload_option
    option = STDIN.gets.chomp
  end

  def return_product
    product = @merchandise.products[@user_selection]
    @user_selection = nil
    return product
  end

  def return_change
    change = @change_due
    @change_due = nil
    return change
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

  def print_product
    @printer.print_product(@merchandise.products[@user_selection], @user_selection)
  end

  def print_reload_options
    @printer.print_reload_options
  end
end
