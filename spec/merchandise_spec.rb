require 'merchandise'
require 'product'

describe Merchandise do
  let(:merchandise) { described_class.new }

  describe '#initialize' do
    it 'has a products attribute that is an array' do
      expect(merchandise.products).to be_an(Array)
    end

    it 'has products that are an instance of the Product class' do
      expect(merchandise.products[4]).to be_an_instance_of(Product)
    end
  end

  describe '#release_product' do
    it 'calls the product\'s #release method' do
      product = spy('product')
      mock_products = [:product, product]
      allow_any_instance_of(Merchandise).to receive(:generate_products) { mock_products }
      test_merchandise = Merchandise.new
      test_merchandise.release_product(1)
      expect(product).to have_received(:release)
    end
  end
end
