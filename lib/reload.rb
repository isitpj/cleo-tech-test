require_relative './printer'
require_relative './merchandise'

class Reload
  attr_reader :printer, :merchandise

  def initialize(merchandise)
    @printer = Printer.new
    @merchandise = merchandise
  end

  def assign_product_or_change
    @printer.print_reload_options
    selection = STDIN.gets.chomp
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
