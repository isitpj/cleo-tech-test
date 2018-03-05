require 'product'

describe Product do
  describe '#initialize' do
    it 'has a name property' do
      kitkat = Product.new('Kit Kat', 90)
      expect(kitkat.name).to eq 'Kit Kat'
    end

    it 'has a price property' do
      kitkat = Product.new('Kit Kat', 90)
      expect(kitkat.price).to eq 90
    end
  end
end
