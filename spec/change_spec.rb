require 'change'

describe Change do
  describe '#initialize' do
    it 'has a coins attribute that is an array' do
      change = Change.new
      expect(change.coins).to be_an(Array)
    end

    it 'has coins that are an instance of the Coin class' do
      change = Change.new
      expect(change.coins[4]).to be_an_instance_of(Coin)
    end
  end
end
