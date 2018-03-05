require 'machine'

describe Machine do
  describe '#initialize' do
    let(:machine) { described_class.new }
    it 'has a merchandise property that is an instance of Merchandise' do
      expect(machine.merchandise).to be_an_instance_of(Merchandise)
    end
  end

  describe '#print_products' do
    let(:machine) { described_class.new }
    it 'calls puts on STDOUT' do
      allow(STDOUT).to receive(:puts)
      machine.print_products
      expect(STDOUT).to have_received(:puts).at_least(1).times
    end
  end
end
