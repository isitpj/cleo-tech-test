require 'machine'
require 'merchandise'

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

  describe '#process_user_selection' do
    it 'assigns the @user_selection variable to a product' do
      allow(STDIN).to receive(:gets) { '1' }
      machine.process_user_selection
      expect(machine.user_selection).to eq 1
    end

    it 'tells the user the price of the product and asks them to insert coins' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets) { '1' }
      machine.process_user_selection
      expect(STDOUT).to have_received(:puts).at_least(1).times
    end
  end

  describe '#accept_coins' do
    it 'calls gets to receive user input' do
      allow(STDIN).to receive(:gets) { '1' }
      machine.process_user_selection
      machine.accept_coins(90)
      expect(STDIN).to have_received(:gets).at_least(2).times
    end

    it 'will not accept coins that are not a valid denomination' do
      allow(STDIN).to receive(:gets) { '3' }
      allow(STDOUT).to receive(:puts)
      machine.accept_coins(90)
      expect(STDOUT).to have_received(:puts).with 'Sorry, that is not a valid denomination.'
    end
  end
end
