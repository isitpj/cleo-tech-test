require_relative './merchandise'
require_relative './change'
require_relative './printer'
require_relative './dispense'
require_relative './reload'

class Machine
  attr_reader :merchandise, :change, :printer, :user_selection, :change_due

  def initialize
    @merchandise = Merchandise.new
    @change = Change.new
    @printer = Printer.new
    @user_selection = nil
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
    return @user_selection = input if input == 'reload' || input == 'exit'
    input = input.to_i - 1
    return @user_selection = input if input >= 0 && input < @merchandise.products.length
    @printer.print_invalid_selection
  end

  def process_user_selection
    dispense(Dispense.new(@user_selection, @merchandise, @change)) if @user_selection.class == Integer
    reload(Reload.new(@merchandise, @change)) if @user_selection == 'reload'
    exit if @user_selection == 'exit'
  end

  def dispense(dispense)
    dispense.dispense_product
  end

  def reload(reload)
    reload.assign_selection_and_reload
  end
end
