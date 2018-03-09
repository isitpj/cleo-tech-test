require_relative './printer'

class Reload
  attr_reader :printer

  def initialize
    @printer = Printer.new
  end

  def assign_product_or_change
    @printer.print_reload_options
    selection = STDIN.gets.chomp
  end
end
