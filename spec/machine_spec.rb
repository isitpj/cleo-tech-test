require 'machine'

describe Machine do
  describe '#initialize' do
    let(:machine) { described_class.new }
    it 'has a merchandise property that is an instance of Merchandise' do
      expect(machine.merchandise).to be_an_instance_of(Merchandise)
    end
  end
end
