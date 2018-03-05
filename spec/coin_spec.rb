require 'coin'

describe Coin do
  describe '#initialize' do
    it 'has a value property that is an integer' do
      coin = Coin.new(50)
      expect(coin.value).to be_an_instance_of(Integer)
    end

    it 'has a quantity property that is assigned to 20 by default' do
      coin = Coin.new(50)
      expect(coin.quantity).to eq 20
    end
  end
end
