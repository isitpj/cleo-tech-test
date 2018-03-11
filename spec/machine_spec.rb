require 'machine'

describe Machine do
  let(:machine) { described_class.new }

  before(:each) do
    allow(STDOUT).to receive(:puts)
    allow(machine).to receive(:loop)
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
  end

  describe '#start' do
    before(:each) do
      allow(machine).to receive(:display_menu)
      allow(machine).to receive(:assign_user_selection)
      allow(machine).to receive(:process_user_selection)
    end

    it 'begins a loop' do
      machine.start
      expect(machine).to have_received(:loop)
    end

    it 'calls #display_menu' do
      expect(machine).to receive(:loop).and_yield
      machine.start
      expect(machine).to have_received(:display_menu)
    end

    it 'calls #assign_user_selection' do
      expect(machine).to receive(:loop).and_yield
      machine.start
      expect(machine).to have_received(:assign_user_selection)
    end

    it 'calls #process_user_selection' do
      expect(machine).to receive(:loop).and_yield
      machine.start
      expect(machine).to have_received(:process_user_selection)
    end
  end

  describe '#display_menu' do
    it 'calls puts on STDOUT' do
      machine.display_menu
      expect(STDOUT).to have_received(:puts).exactly(16).times
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

    it 'calls #dispense' do
      allow(STDIN).to receive(:gets) { '1' }
      allow(machine).to receive(:dispense)
      machine.assign_user_selection
      machine.process_user_selection
      expect(machine).to have_received(:dispense)
    end

    it 'calls #reload' do
      allow(STDIN).to receive(:gets) { 'reload' }
      allow(machine).to receive(:reload)
      machine.assign_user_selection
      machine.process_user_selection
      expect(machine).to have_received(:reload)
    end

    it 'calls Printer#print_invalid_selection' do
      printer = spy('printer')
      allow(Printer).to receive(:new) { printer }
      allow(STDIN).to receive(:gets) { '22' }
      test_machine = Machine.new
      test_machine.assign_user_selection
      test_machine.process_user_selection
      expect(printer).to have_received(:print_invalid_selection)
    end

    it 'resets user_selection to nil' do
      allow(STDIN).to receive(:gets) { '1' }
      allow(machine).to receive(:dispense)
      machine.assign_user_selection
      machine.process_user_selection
      expect(machine.user_selection).to eq nil
    end
  end

  describe '#dispense' do
    it 'calls #dispense on an instance of Reload' do
      fake_dispense = double('dispense')
      allow(fake_dispense).to receive_messages(
        dispense_product: nil,
        merchandise: nil,
        change: nil
      )
      machine.dispense(fake_dispense)
      expect(fake_dispense).to have_received(:dispense_product)
    end
  end

  describe '#reload' do
    it 'calls #assign_product_or_change on an instance of Reload' do
      fake_reload = double('reload')
      allow(fake_reload).to receive_messages(
        assign_selection_and_reload: nil,
        merchandise: nil,
        change: nil
      )
      machine.reload(fake_reload)
      expect(fake_reload).to have_received(:assign_selection_and_reload)
    end
  end
end
