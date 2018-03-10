require 'merchandise'

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
      test_merchandise = stub_generate_products(product)
      test_merchandise.release_product(1)
      expect(product).to have_received(:release)
    end
  end

  describe '#reload_product' do
    it 'calls the product\'s reload method' do
      product = spy('product')
      test_merchandise = stub_generate_products(product)
      test_merchandise.reload_product(1, 6)
      expect(product).to have_received(:reload).with(6)
    end
  end
end
