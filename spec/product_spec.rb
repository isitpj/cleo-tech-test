require 'product'

describe Product do
  let(:kitkat) { described_class.new('Kit Kat', 90, 10)}

  describe '#initialize' do
    it 'has a name property' do
      expect(kitkat.name).to eq 'Kit Kat'
    end

    it 'has a price property' do
      expect(kitkat.price).to eq 90
    end

    it 'has a quantity property' do
      expect(kitkat.quantity).to eq 10
    end
  end

  describe '#release' do
    it 'decreases the quantity by one' do
      expect{kitkat.release}.to change{kitkat.quantity}.from(10).to(9)
    end
  end

  describe '#reload' do
    it 'increases the quantity by 5' do
      expect{kitkat.reload(5)}.to change{kitkat.quantity}.from(10).to(15)
    end
  end
end
