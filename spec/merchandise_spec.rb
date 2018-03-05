require 'merchandise'
require 'product'

describe Merchandise do
  describe '#initialize' do
    it 'has a products attribute that is an array' do
      merchandise = Merchandise.new
      expect(merchandise.products).to be_an(Array)
    end

    it 'has products that are an instance of the Product class' do
      merchandise = Merchandise.new
      expect(merchandise.products[4]).to be_an_instance_of(Product)
    end
  end
end
