require_relative './merchandise'
require_relative './change'
require_relative './printer'

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

  def start
    loop do
      display_menu
      assign_user_selection
      process_user_selection
    end
  end

  def display_menu
    @printer.print_welcome_message
    @printer.print_product_selection(@merchandise)
    @printer.print_options_message
  end

  def assign_user_selection
    input = STDIN.gets.chomp.downcase
    if input == 'reload' || input == 'exit'
      @user_selection = input
    else
      @user_selection = input.to_i - 1
    end
  end

  def process_user_selection
    dispense if @user_selection.class == Integer
    get_reload_option if @user_selection == 'reload'
    exit if @user_selection == 'exit'
  end

  def dispense
    price = @merchandise.products[@user_selection].price
    accept_coins(price)
    return_product
    return_change
  end

  def accept_coins(price)
    coins = get_coins(price)
    coins.each { |coin| @change.insert_coin(coin, 1) }
    @change_due = @change.return_change(coins, price) if sum(coins) > price
  end

  def get_reload_option
    @printer.print_reload_options
    option = STDIN.gets.chomp.downcase
    reload_product if option == 'product'
    reload_coin if option == 'change'
  end

  def reload_product
    @printer.print_product_selection(@merchandise)
    product_index = STDIN.gets.chomp.to_i - 1
    @printer.request_quantity
    quantity = STDIN.gets.chomp.to_i
    @merchandise.reload_product(product_index, quantity)
  end

  def reload_coin
    @printer.request_coin_selection
    denomination = STDIN.gets.chomp.to_i
    @printer.request_quantity
    quantity = STDIN.gets.chomp.to_i
    @change.insert_coin(denomination, quantity)
  end

  def return_product
    product = @merchandise.products[@user_selection]
    @user_selection = nil
    @printer.print_return_product(product)
  end

  def return_change
    change = @change_due
    @change_due = nil
    @printer.print_return_change(change) if change != nil
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
