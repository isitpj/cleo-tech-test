require 'merchandise'

class Machine
  VALID_DENOMINATIONS = [200, 100, 50, 20, 10, 5, 2, 1]
  attr_reader :merchandise, :user_selection

  def initialize
    @merchandise = Merchandise.new
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
    puts "A #{@merchandise.products[@user_selection].name} costs #{@merchandise.products[@user_selection].price}. Please insert coins."
  end

  def accept_coins
    price = @merchandise.products[@user_selection].price
    inserted_coins = []
    inserted = STDIN.gets.chomp
  end
end
