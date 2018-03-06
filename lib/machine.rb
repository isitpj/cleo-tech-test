class Machine
  attr_reader :merchandise, :user_selection

  def initialize
    @merchandise = Merchandise.new
    @user_selection = nil
  end

  def print_products
    @merchandise.products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name}. Price: #{product.price}"
    end
  end

  def process_user_selection
    index = STDIN.gets.chomp.to_i
    @user_selection = @merchandise.products[index]
  end
end
