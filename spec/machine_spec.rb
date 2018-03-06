require 'machine'

describe Machine do
  let(:machine) { described_class.new }

  describe '#initialize' do
    it 'has a merchandise property that is an instance of Merchandise' do
      expect(machine.merchandise).to be_an_instance_of(Merchandise)
    end

    it 'has a user_selection property that is nil by default' do
      expect(machine).to have_attributes(:user_selection => nil)
    end
  end

  describe '#print_products' do
    it 'calls puts on STDOUT' do
      allow(STDOUT).to receive(:puts)
      machine.print_products
      expect(STDOUT).to have_received(:puts).at_least(1).times
    end
  end
end
