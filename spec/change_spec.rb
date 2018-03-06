require 'change'
require 'coin'

describe Change do
  let(:change) { described_class.new }
  describe '#initialize' do
    it 'has a coins attribute that is an array' do
      expect(change.coins).to be_an(Array)
    end

    it 'has coins that are an instance of the Coin class' do
      expect(change.coins[4]).to be_an_instance_of(Coin)
    end
  end

  describe '#release_coin' do
    it 'calls the coin\'s release method' do
      puts 'Huh, ReleaseCoin? That\'d be a terrible name for a crypto token.'
      coin = spy('coin')
      test_change = stub_generate_coins(coin)
      test_change.release_coin(1, 1)
      expect(coin).to have_received(:release).with(1)
    end
  end

  describe '#insert_coin' do
    it 'calls the coin\'s insert method' do
      puts 'Not sure InsertCoin is a much better name either...'
      coin = spy('coin')
      test_change = stub_generate_coins(coin)
      test_change.insert_coin(1, 7)
      expect(coin).to have_received(:insert).with(7)
    end
  end
end
