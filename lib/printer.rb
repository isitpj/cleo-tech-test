class Printer
  def print_product(product, index)
    STDOUT.puts "#{index + 1}. #{product.name}. Price: #{product.price}"
  end

  def print_reload_option
    STDOUT.puts 'Please enter \'reload\' to add more products or change to the machine.'
  end

  def request_coins
    STDOUT.puts 'Please insert coins.'
  end

  def invalid_coin_inserted
    STDOUT.puts 'Sorry, that is not a valid denomination.'
  end
end
