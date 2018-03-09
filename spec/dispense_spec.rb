require 'dispense'

describe Dispense do
  let(:dispense) { described_class.new(1, Merchandise.new, Change.new) }

  before(:each) do
    allow(STDOUT).to receive(:puts)
  end

  describe '#initialize' do
    it 'has a printer variable set to an instance of Printer' do
      expect(dispense.printer).to be_an_instance_of(Printer)
    end

    it 'has a merchandise variable that is an instance of Merchandise' do
      expect(dispense.merchandise).to be_an_instance_of(Merchandise)
    end

    it 'has a change variable that is an instance of Change' do
      expect(dispense.change).to be_an_instance_of(Change)
    end

    it 'has a selection variable that is an Integer' do
      expect(dispense.selection).to be_an_instance_of(Integer)
    end

    it 'has a change_due that is nil by default' do
      expect(dispense.change_due).to eq nil
    end
  end

  describe '#accept_coins' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('3', '50', '20', '20')
    end

    it 'calls gets to receive user input' do
      dispense.accept_coins(90)
      expect(STDIN).to have_received(:gets).at_least(2).times
    end

    it 'will not accept coins that are not a valid denomination' do
      dispense.accept_coins(90)
      expect(STDOUT).to have_received(:puts).with 'Sorry, that is not a valid denomination.'
    end

    it 'calls the Change class\'s insert_coin method for each coin inserted' do
      merchandise = double('merchandise')
      change = spy('change')
      allow(Change).to receive(:new) { change }
      test_dispense = Dispense.new(1, merchandise, change)
      test_dispense.accept_coins(90)
      expect(change).to have_received(:insert_coin).exactly(3).times
    end

    it 'returns 30p of change' do
      allow(STDIN).to receive(:gets).and_return('3', '50', '20', '50')
      expect(dispense.accept_coins(90)).to eq [20, 10]
    end

    it 'returns 40p of change' do
      allow(STDIN).to receive(:gets).and_return('20', '20', '20', '20', '50')
      expect(dispense.accept_coins(90)).to eq [20, 20]
    end

    it 'decreases the quantity of a coin stored' do
      allow(STDIN).to receive(:gets).and_return('20', '20', '20', '20', '50')
      expect { dispense.accept_coins(90) }.to change { dispense.change.coins[3].quantity }.from(20).to(22)
    end
  end
end
