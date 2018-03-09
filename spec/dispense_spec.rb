require 'dispense'

describe Dispense do
  describe '#initialize' do
    let(:dispense) { described_class.new(1, Merchandise.new, Change.new) }
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
end
