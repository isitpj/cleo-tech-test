require 'printer'

describe Printer do
  let(:printer) { described_class.new }

  before(:each) do
    allow(STDOUT).to receive(:puts)
  end

  describe '#print_welcome_message' do
    it 'prints a header message' do
      printer.print_welcome_message
      expect(STDOUT).to have_received(:puts).exactly(2).times
    end
  end

  describe '#print_product_selection' do
    it 'prints all the products in the vending machine' do
      product = double('product', name: 'Dairy Milk', price: 80, quantity: 5)
      merchandise = double('merchandise', products: [product])
      printer.print_product_selection(merchandise)
      expect(STDOUT).to have_received(:puts).exactly(1).times
    end
  end

  describe '#print_product' do
    it 'prints out a product' do
      product = double('product', name: 'Dairy Milk', price: 80, quantity: 5)
      printer.print_product(product, 0)
      expect(STDOUT).to have_received(:puts).with '1. Dairy Milk. Price: 80p'
    end

    it 'prints that the product is sold out if its quantity is 0' do
      product = double('product', name: 'Dairy Milk', quantity: 0)
      printer.print_product(product, 0)
      expect(STDOUT).to have_received(:puts).with '1. Dairy Milk. SOLD OUT.'
    end
  end

  describe '#print_invalid_selection' do
    it 'prints a message informing the user that they have made an invalid selection' do
      printer.print_invalid_selection
      expect(STDOUT).to have_received(:puts).with 'Sorry, that selection was invalid. Please make another.'
    end
  end

  describe '#print_options_message' do
    it 'prints a string offering the user the option to reload the machine' do
      printer.print_options_message
      expect(STDOUT).to have_received(:puts).with 'Please enter a number to make your selection, \'Reload\' if you would like to add more products to the machine, or \'Exit\' if you do not wish to be trapped inside a command-line vending machine for all eternity.'
    end
  end

  describe '#request_coins' do
    it 'prints a string asking the user to insert coins' do
      printer.request_coins
      expect(STDOUT).to have_received(:puts).with 'Please insert coins in units of pence (e.g. "1", "50", "200").'
    end
  end

  describe '#invalid_coin_inserted' do
    it 'prints a string informing the user that they have tried to insert an invalid coin' do
      printer.invalid_coin_inserted
      expect(STDOUT).to have_received(:puts).with 'Sorry, that is not a valid denomination.'
    end
  end

  describe '#print_sold_out_message' do
    it 'prints a message informing the user that the item is sold out' do
      printer.print_sold_out_message
      expect(STDOUT).to have_received(:puts).with 'Sorry, that item is sold out.'
    end
  end

  describe '#print_reload_options' do
    it 'prints a string asking the user if they would like to reload products or change' do
      printer.print_reload_options
      expect(STDOUT).to have_received(:puts).with 'Would you like to reload products or change? Please enter either \'Product\' or \'Change\'.'
    end
  end

  describe '#request_quantity' do
    it 'prints a string asking the user how many they would like to reload' do
      printer.request_quantity
      expect(STDOUT).to have_received(:puts).with 'How many would you like to reload?'
    end
  end

  describe '#request_coin_selection' do
    it 'prints a string asking the user which coin denomination they would like to reload' do
      printer.request_coin_selection
      expect(STDOUT).to have_received(:puts).with 'What denomination of coin would you like to reload? Please input either 1, 2, 5, 10, 20, 50, 100, or 200.'
    end
  end

  describe '#print_return_product' do
    it 'prints a string telling the user to take their product' do
      product = double('product', name: 'Dairy Milk')
      printer.print_return_product(product)
      expect(STDOUT).to have_received(:puts).with 'Thank you for visiting The World\'s Best vending Machine(TM). Please take your Dairy Milk.'
    end
  end

  describe '#print_return_change' do
    it 'prints a string telling the user to take their change' do
      change = [20, 10]
      printer.print_return_change(change)
      expect(STDOUT).to have_received(:puts).exactly(3).times
    end
  end

  describe '#print_successful_reload' do
    it 'prints a message informing the user that reloading the vending machine has been successful' do
      printer.print_successful_reload
      expect(STDOUT).to have_received(:puts).with 'The vending machine has been reloaded. Well done you!'
    end
  end
end
