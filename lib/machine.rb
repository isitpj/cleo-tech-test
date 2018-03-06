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
end
