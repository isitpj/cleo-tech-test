require 'merchandise'
require 'change'

class Machine
  VALID_DENOMINATIONS = [200, 100, 50, 20, 10, 5, 2, 1]
  attr_reader :merchandise, :change, :user_selection

  def initialize
    @merchandise = Merchandise.new
    @change = Change.new
    @user_selection = nil
  end

  def print_products
    @merchandise.products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name}. Price: #{product.price}"
    end
    puts 'Please enter \'reload\' to add more products or change to the machine.'
  end

  def process_user_selection
    @user_selection = STDIN.gets.chomp.to_i
    product_name = @merchandise.products[@user_selection].name
    product_price = @merchandise.products[@user_selection].price
    STDOUT.puts "A #{product_name} costs #{product_price}p. Please insert coins."
  end

  def accept_coins(price)
    inserted_coins = []
    inserted = STDIN.gets.chomp.to_i
    if (VALID_DENOMINATIONS.include?(inserted))
      inserted_coins << inserted
    else
      STDOUT.puts 'Sorry, that is not a valid denomination.'
    end
  end
end
