require 'coin'

describe Coin do
  let(:coin) { described_class.new(50) }
  describe '#initialize' do
    it 'has a value property that is an integer' do
      expect(coin.value).to be_an_instance_of(Integer)
    end

    it 'has a quantity property that is assigned to 20 by default' do
      expect(coin.quantity).to eq 20
    end
  end

  describe '#release' do
    it 'decreases the quantity of a coin' do
      expect { coin.release(2) }.to change { coin.quantity }.from(20).to(18)
    end
  end
end
