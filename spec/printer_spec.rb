require 'printer'

describe Printer do
  describe '#print_product' do
    it 'prints out a product' do
      allow(STDOUT).to receive(:puts)
      product = double('product')
      allow(product).to receive_messages(name: 'Dairy Milk', price: 80)
      printer = Printer.new
      printer.print_product(product, 1)
      expect(STDOUT).to have_received(:puts)
    end
  end
end
