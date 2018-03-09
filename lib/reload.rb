require_relative './printer'
require_relative './merchandise'
require_relative './change'

class Reload
  attr_reader :printer, :merchandise, :change

  def initialize(merchandise, change)
    @printer = Printer.new
    @merchandise = merchandise
    @change = change
  end

  def assign_product_or_change
    @printer.print_reload_options
    selection = STDIN.gets.chomp
    reload_coin if selection == 'change'
  end

  def reload_coin
    denomination = assign_denomination
    quantity = assign_quantity
    insert_coins(denomination, quantity)
  end

  def reload_product
    @printer.print_product_selection(@merchandise)
    @printer.request_quantity
    @printer.print_successful_reload
  end

  private

  def assign_denomination
    @printer.request_coin_selection
    STDIN.gets.chomp.to_i
  end

  def assign_quantity
    @printer.request_quantity
    STDIN.gets.chomp.to_i
  end

  def insert_coins(denomination, quantity)
    @change.insert_coin(denomination, quantity)
    @printer.print_successful_reload
  end
end






# def reload_product
#   product_index = STDIN.gets.chomp.to_i - 1
#   quantity = STDIN.gets.chomp.to_i
#   @merchandise.reload_product(product_index, quantity)
# end
