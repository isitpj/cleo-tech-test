require 'product'

describe Product do
  describe '#initialize' do
    it 'has a name property' do
      kitkat = Product.new('Kit Kat')
      expect(kitkat.name).to eq 'Kit Kat'
    end
  end
end
