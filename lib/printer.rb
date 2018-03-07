class Printer
  def print_product(product, index)
    STDOUT.puts "#{index + 1}. #{product.name}. Price: #{product.price}"
  end
end
