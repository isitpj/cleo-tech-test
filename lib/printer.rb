class Printer
  def print_welcome_message
    STDOUT.puts 'Welcome to The World\'s Best Vending Machine(TM).'
    STDOUT.puts 'Did you know that the first known vending existed in Alexandria, Egypt, in the first century? Bet you didn\'t.'
  end

  def print_product_selection(merchandise)
    merchandise.products.each_with_index do |product, index|
      print_product(product, index)
    end
  end

  def print_product(product, index)
    STDOUT.puts "#{index + 1}. #{product.name}. Price: #{product.price}p" if product.quantity > 0
    STDOUT.puts "#{index + 1}. #{product.name}. SOLD OUT." if product.quantity if product.quantity <= 0
  end

  def print_options_message
    STDOUT.puts 'Please enter a number to make your selection, \'Reload\' if you would like to add more products to the machine, or \'Exit\' if you do not wish to be trapped inside a command-line vending machine for all eternity.'
  end

  def print_invalid_selection
    STDOUT.puts 'Sorry, that selection was invalid. Please make another.'
  end

  def request_coins
    STDOUT.puts 'Please insert coins.'
  end

  def invalid_coin_inserted
    STDOUT.puts 'Sorry, that is not a valid denomination.'
  end

  def print_sold_out_message
    STDOUT.puts 'Sorry, that item is sold out.'
  end

  def print_reload_options
    STDOUT.puts 'Would you like to reload products or change? Please enter either \'Product\' or \'Change\'.'
  end

  def request_quantity
    STDOUT.puts 'How many would you like to reload?'
  end

  def request_coin_selection
    STDOUT.puts 'What denomination of coin would you like to reload? Please input either 1, 2, 5, 10, 20, 50, 100, or 200.'
  end

  def print_return_product(product)
    STDOUT.puts "Thank you for visiting The World\'s Best vending Machine(TM). Please take your #{product.name}."
  end

  def print_return_change(change)
    STDOUT.puts 'Please take your change:'
    change.each do |coin|
      puts "#{coin}p"
    end
  end

  def print_successful_reload
    STDOUT.puts 'The vending machine has been reloaded. Well done you!'
  end
end
