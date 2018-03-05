require 'product'

describe Product do
  let(:kitkat) { described_class.new('Kit Kat', 90)}

  describe '#initialize' do
    it 'has a name property' do
      expect(kitkat.name).to eq 'Kit Kat'
    end

    it 'has a price property' do
      expect(kitkat.price).to eq 90
    end
  end
end
