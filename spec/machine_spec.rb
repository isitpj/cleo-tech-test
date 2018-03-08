require 'machine'

describe Machine do
  let(:machine) { described_class.new }

  describe '#initialize' do
    it 'has a merchandise property that is an instance of Merchandise' do
      expect(machine.merchandise).to be_an_instance_of(Merchandise)
    end

    it 'has a change property that is an instance of Change' do
      expect(machine.change).to be_an_instance_of(Change)
    end

    it 'has a printer property that is an instance of Printer' do
      expect(machine.printer).to be_an_instance_of(Printer)
    end

    it 'has a user_selection property that is nil by default' do
      expect(machine).to have_attributes(user_selection: nil)
    end

    it 'has a change_due property that is nil by default' do
      expect(machine).to have_attributes(change_due: nil)
    end
  end

  describe '#display_menu' do
    it 'calls puts on STDOUT' do
      allow(STDOUT).to receive(:puts)
      machine.display_menu
      expect(STDOUT).to have_received(:puts).at_least(1).times
    end
  end

  describe '#assign_user_selection' do

    it 'assigns the @user_selection variable to an integer' do
      allow(STDIN).to receive(:gets) { '1' }
      machine.assign_user_selection
      expect(machine.user_selection).to eq 0
    end

    it 'assigns the @user_selection variable to \'reload\'' do
      allow(STDIN).to receive(:gets) { 'reload' }
      machine.assign_user_selection
      expect(machine.user_selection).to eq 'reload'
    end
  end

  describe '#process_user_selection' do
    before(:each) do
      allow(STDOUT).to receive(:puts)
    end

    it 'calls #print_product private method' do
      allow(STDIN).to receive(:gets) { '1' }
      allow(machine).to receive(:print_product)
      machine.assign_user_selection
      machine.process_user_selection
      expect(machine).to have_received(:print_product)
    end

    it 'calls #print_reload_options private method' do
      allow(STDIN).to receive(:gets) { 'reload' }
      allow(machine).to receive(:print_reload_options)
      machine.assign_user_selection
      machine.process_user_selection
      expect(machine).to have_received(:print_reload_options)
    end
  end

  describe '#accept_coins' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('3', '50', '20', '20')
      allow(STDOUT).to receive(:puts)
    end

    it 'calls gets to receive user input' do
      machine.accept_coins(90)
      expect(STDIN).to have_received(:gets).at_least(2).times
    end

    it 'will not accept coins that are not a valid denomination' do
      machine.accept_coins(90)
      expect(STDOUT).to have_received(:puts).with 'Sorry, that is not a valid denomination.'
    end

    it 'calls the Change class\'s insert_coin method for each coin inserted' do
      change = spy('change')
      allow(Change).to receive(:new) { change }
      test_machine = Machine.new
      test_machine.accept_coins(90)
      expect(change).to have_received(:insert_coin).exactly(3).times
    end

    it 'returns 30p of change' do
      allow(STDIN).to receive(:gets).and_return('3', '50', '20', '50')
      expect(machine.accept_coins(90)).to eq [20, 10]
    end

    it 'returns 40p of change' do
      allow(STDIN).to receive(:gets).and_return('20', '20', '20', '20', '50')
      expect(machine.accept_coins(90)).to eq [20, 20]
    end

    it 'decreases the quantity of a coin stored' do
      allow(STDIN).to receive(:gets).and_return('20', '20', '20', '20', '50')
      expect { machine.accept_coins(90) }.to change { machine.change.coins[3].quantity }.from(20).to(22)
    end
  end

  describe '#return_product' do
    before(:each) do
      allow(STDIN).to receive(:gets) { '1' }
      allow(STDOUT).to receive(:puts)
      machine.assign_user_selection
      machine.process_user_selection
    end

    it 'returns a Product object' do
      expect(machine.return_product).to be_an_instance_of(Product)
    end

    it 'resets @user_selection to nil' do
      machine.return_product
      expect(machine.user_selection).to eq nil
    end
  end

  describe '#return_change' do
    before(:each) do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('50', '20', '20')
    end

    it 'returns an array of integer values' do
      machine.accept_coins(80)
      expect(machine.return_change[0]).to be_an(Integer)
    end

    it 'resets @change_due to nil' do
      machine.accept_coins(80)
      machine.return_change
      expect(machine.change_due).to eq nil
    end
  end
end
