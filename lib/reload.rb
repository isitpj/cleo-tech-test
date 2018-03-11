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

  def assign_selection_and_reload
    @printer.print_reload_options
    selection = STDIN.gets.chomp
    return reload_coin if selection == 'change'
    return reload_product if selection == 'product'
    @printer.print_invalid_selection
  end

  def reload_coin
    denomination = assign_denomination
    quantity = assign_quantity
    insert_coins(denomination, quantity)
  end

  def reload_product
    product_index = assign_product_index
    quantity = assign_quantity
    reload_specified_products(product_index, quantity)
  end

  private

  def assign_denomination
    @printer.request_coin_selection
    STDIN.gets.chomp.to_i
  end

  def assign_product_index
    @printer.print_product_selection(@merchandise)
    STDIN.gets.chomp.to_i - 1
  end

  def assign_quantity
    @printer.request_quantity
    STDIN.gets.chomp.to_i
  end

  def insert_coins(denomination, quantity)
    @change.insert_coin(denomination, quantity)
    @printer.print_successful_reload
  end

  def reload_specified_products(index, quantity)
    @merchandise.reload_product(index, quantity)
    @printer.print_successful_reload
  end
end
