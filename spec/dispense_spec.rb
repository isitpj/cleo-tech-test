require 'dispense'

describe Dispense do
  let(:dispense) { described_class.new(1, Merchandise.new, Change.new) }

  before(:each) do
    allow(STDOUT).to receive(:puts)
    allow(STDIN).to receive(:gets).and_return('3', '50', '20', '20')
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

  describe '#dispense_product' do
    before(:each) do
      allow(dispense).to receive(:accept_coins)
      allow(dispense).to receive(:return_product)
      allow(dispense).to receive(:return_change)
    end

    it 'calls the Printer\'s #print_sold_out_message method' do
      printer = spy('printer')
      allow(Printer).to receive(:new) { printer }
      change = double('change')
      product = double('product', name: 'Dairy Milk', quantity: 0)
      merchandise = double('merchandise', products: [product])
      test_dispense = Dispense.new(0, merchandise, change)
      test_dispense.dispense_product
      expect(printer).to have_received(:print_sold_out_message)
    end

    it 'calls #accept_coins' do
      dispense.dispense_product
      expect(dispense).to have_received(:accept_coins)
    end

    it 'calls #return_product' do
      dispense.dispense_product
      expect(dispense).to have_received(:return_product)
    end

    it 'calls #return_change' do
      dispense.dispense_product
      expect(dispense).to have_received(:return_change)
    end
  end

  describe '#accept_coins' do
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

  describe '#return_product_and_change' do
    it 'calls #return_product' do
      allow(dispense).to receive(:return_product)
      dispense.return_product_and_change
      expect(dispense).to have_received(:return_product)
    end

    it 'calls #return_change' do
      allow(dispense).to receive(:return_change)
      dispense.return_product_and_change
      expect(dispense).to have_received(:return_change)
    end
  end

  describe '#return_product' do
    before(:each) do
      allow(STDIN).to receive(:gets) { '1' }
    end

    it 'calls the Merchandise class\'s #release_product method' do
      merchandise = spy('merchandise')
      change = double('change')
      test_dispense = Dispense.new(1, merchandise, change)
      test_dispense.return_product
      expect(merchandise).to have_received(:release_product).with(1)
    end

    it 'calls the Printer class\'s #print_return_product method' do
      merchandise = double('merchandise')
      allow(merchandise).to receive_messages(
        products: [double, double],
        release_product: nil
      )
      change = double('change')
      printer = spy('printer')
      allow(Printer).to receive(:new) { printer }
      test_dispense = Dispense.new(1, merchandise, change)
      test_dispense.return_product
      expect(printer).to have_received(:print_return_product)
    end

    it 'resets @user_selection to nil' do
      dispense.return_product
      expect(dispense.selection).to eq nil
    end
  end

  describe '#return_change' do
    it 'calls the Printer class\'s #print_return_change method' do
      dispense.accept_coins(80)
      expect(dispense.return_change[0]).to be_an(Integer)
    end
  end
end
