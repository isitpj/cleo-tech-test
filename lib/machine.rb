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

  def print_products
    @merchandise.products.each_with_index do |product, index|
      @printer.print_product(product, index)
    end
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
    coins = []
    coins = get_coins(coins, price)
    coins.each { |coin| @change.insert_coin(coin, 1) }
    total_inserted = coins.reduce(:+)
    change?(total_inserted, price) ? @change_due = get_change(total_inserted, price) : coins
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

  def get_coins(coins, price)
    inserted_amount = 0
    while inserted_amount < price
      @printer.request_coins
      inserted_coin = STDIN.gets.chomp.to_i
      if VALID_DENOMINATIONS.include?(inserted_coin)
        coins << inserted_coin
        inserted_amount += inserted_coin
      else
        @printer.invalid_coin_inserted
      end
    end
    coins
  end

  def get_change(total_inserted, price)
    change_due = total_inserted - price
    remainder = change_due
    change = []
    until change.reduce(:+) == change_due
      @change.coins.each do |coin|
        if coin.value <= remainder
          change << coin.value
          remainder -= coin.value
          @change.release_coin(coin.value, 1)
          break
        end
      end
    end
    change
  end

  def change?(total, price)
    total > price
  end

  def print_product
    product_name = @merchandise.products[@user_selection].name
    product_price = @merchandise.products[@user_selection].price
    @printer.print_product(@merchandise.products[@user_selection], @user_selection)
  end

  def print_reload_options
    @printer.print_reload_options
  end
end
