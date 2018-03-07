class Printer
  def print_product(product, index)
    STDOUT.puts "#{index + 1}. #{product.name}. Price: #{product.price}"
  end

  def print_reload_option
    puts 'Please enter \'reload\' to add more products or change to the machine.'
  end

  def request_coins
    puts 'Please insert coins.'
  end
end
