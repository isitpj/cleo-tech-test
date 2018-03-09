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
  end

  def reload_coin
    @printer.request_coin_selection
    denomination = STDIN.gets.chomp
    @printer.request_quantity
    quantity = STDIN.gets.chomp
    @printer.print_successful_reload
  end
end






# def reload_product
#   @printer.print_product_selection(@merchandise)
#   product_index = STDIN.gets.chomp.to_i - 1
#   @printer.request_quantity
#   quantity = STDIN.gets.chomp.to_i
#   @merchandise.reload_product(product_index, quantity)
#   @printer.print_successful_reload
# end
#
# def reload_coin
#   @printer.request_coin_selection
#   denomination = STDIN.gets.chomp.to_i
#   @printer.request_quantity
#   quantity = STDIN.gets.chomp.to_i
#   @change.insert_coin(denomination, quantity)
#   @printer.print_successful_reload
# end
