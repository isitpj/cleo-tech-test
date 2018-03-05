class Machine
  attr_reader :merchandise

  def initialize
    @merchandise = Merchandise.new
  end

  def print_products
    @merchandise.products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name}. Price: #{product.price}"
    end
  end
end
