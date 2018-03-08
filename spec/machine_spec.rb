require 'machine'

describe Machine do
  let(:machine) { described_class.new }

  before(:each) do
    allow(STDOUT).to receive(:puts)
  end

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

  describe '#start' do
    before(:each) do
      allow(machine).to receive(:display_menu)
      allow(machine).to receive(:assign_user_selection)
      allow(machine).to receive(:process_user_selection)
    end

    it 'calls #display_menu' do
      machine.start
      expect(machine).to have_received(:display_menu)
    end

    it 'calls #assign_user_selection' do
      machine.start
      expect(machine).to have_received(:assign_user_selection)
    end

    it 'calls #process_user_selection' do
      machine.start
      expect(machine).to have_received(:process_user_selection)
    end
  end

  describe '#display_menu' do
    it 'calls puts on STDOUT' do
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

  describe '#dispense' do
    it 'calls #accept_coins' do
      allow(STDIN).to receive(:gets) { '1' }
      allow(machine).to receive(:accept_coins)
      machine.assign_user_selection
      machine.dispense
      expect(machine).to have_received(:accept_coins)
    end

    it 'calls #return_product' do
      allow(STDIN).to receive(:gets) { '1' }
      allow(machine).to receive(:accept_coins)
      allow(machine).to receive(:return_product)
      machine.assign_user_selection
      machine.dispense
      expect(machine).to have_received(:return_product)
    end
  end

  describe '#accept_coins' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('3', '50', '20', '20')
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

  describe '#get_reload_option' do
    before(:each) do
      allow(STDIN).to receive(:gets) { 'product' }
      allow(machine).to receive(:reload_coin)
      allow(machine).to receive(:reload_product)
    end

    it 'should get input from the user' do
      machine.get_reload_option
      expect(STDIN).to have_received(:gets)
    end

    it 'calls #reload_product' do
      machine.get_reload_option
      expect(machine).to have_received(:reload_product)
    end

    it 'calls #reload_coin' do
      allow(STDIN).to receive(:gets) { 'change' }
      machine.get_reload_option
      expect(machine).to have_received(:reload_coin)
    end
  end

  describe '#reload_product' do
    it 'calls the Merchandise class\' #reload_product method' do
      allow(STDIN).to receive(:gets).and_return('2', '5')
      merchandise = spy('merchandise')
      allow(Merchandise).to receive(:new) { merchandise }
      test_machine = Machine.new
      test_machine.reload_product
      expect(merchandise).to have_received(:reload_product).with(1, 5)
    end
  end

  describe '#reload_coin' do
    it 'calls the Change class\'s #insert_coin method' do
      allow(STDIN).to receive(:gets).and_return('100', '5')
      change = spy('change')
      allow(Change).to receive(:new) { change }
      test_machine = Machine.new
      test_machine.reload_coin
      expect(change).to have_received(:insert_coin).with(100, 5)
    end
  end

  describe '#return_product' do
    before(:each) do
      allow(STDIN).to receive(:gets) { '1' }
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
