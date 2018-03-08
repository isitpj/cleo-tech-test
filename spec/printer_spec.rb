require 'printer'

describe Printer do
  let(:printer) { described_class.new }

  before(:each) do
    allow(STDOUT).to receive(:puts)
  end

  describe '#print_product_selection' do
    it 'prints all the products in the vending machine' do
      product = double('product', name: 'Dairy Milk', price: 80)
      merchandise = double('merchandise', products: [product])
      printer.print_product_selection(merchandise)
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#print_product' do
    it 'prints out a product' do
      product = double('product', name: 'Dairy Milk', price: 80)
      printer.print_product(product, 1)
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#print_reload_option' do
    it 'prints a string offering the user the option to reload the machine' do
      printer.print_reload_option
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#request_coins' do
    it 'prints a string asking the user to insert coins' do
      printer.request_coins
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#invalid_coin_inserted' do
    it 'prints a string informing the user that they have tried to insert an invalid coin' do
      printer.invalid_coin_inserted
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#print_reload_options' do
    it 'prints a string asking the user if they would like to reload products or change' do
      printer.print_reload_options
      expect(STDOUT).to have_received(:puts)
    end
  end

  describe '#request_quantity' do
    it 'prints a string asking the user how many they would like to reload' do
      printer.request_quantity
      expect(STDOUT).to have_received(:puts)
    end
  end
end
