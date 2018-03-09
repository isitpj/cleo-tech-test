require 'reload'

describe Reload do
  let(:reload) { described_class.new(Merchandise.new, Change.new) }

  describe '#initialize' do
    it 'has a @printer variable that is an instance of Printer' do
      expect(reload.printer).to be_an_instance_of(Printer)
    end

    it 'has a merchandise variable that is an instance of Merchandise' do
      expect(reload.merchandise).to be_an_instance_of(Merchandise)
    end

    it 'has a change variable that is an instance of Change' do
      expect(reload.change).to be_an_instance_of(Change)
    end
  end

  describe '#assign_product_or_change' do
    before(:each) do
      allow(STDIN).to receive(:gets) { 'change' }
      allow(STDOUT).to receive(:puts)
    end

    it 'calls the Printer class\'s #print_reload_options method' do
      printer = spy('printer')
      allow(Printer).to receive(:new) { printer }
      allow_any_instance_of(Change).to receive(:insert_coin)
      reload.assign_product_or_change
      expect(printer).to have_received(:print_reload_options)
    end

    it 'calls gets to receive user input' do
      allow(reload).to receive(:reload_coin)
      reload.assign_product_or_change
      expect(STDIN).to have_received(:gets)
    end

    it 'calls #reload_coin' do
      allow(reload).to receive(:reload_coin)
      reload.assign_product_or_change
      expect(reload).to have_received(:reload_coin)
    end
  end

  describe '#reload_coin' do
    before(:each) do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('100', '5' )
      allow(reload.change).to receive(:insert_coin)
      reload.reload_coin
    end

    it 'prints three statements to the user' do
      expect(STDOUT).to have_received(:puts).exactly(3).times
    end

    it 'gets user input twice' do
      expect(STDIN).to have_received(:gets).twice
    end

    it 'calls the Change class\'s insert_coin method' do
      expect(reload.change).to have_received(:insert_coin).with(100, 5)
    end
  end

  describe '#reload_product' do
    it 'prints three statements to the user' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('1', '5')
      reload.reload_product
      expect(STDOUT).to have_received(:puts).exactly(10).times
    end

    it 'gets user input twice' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('1', '5')
      reload.reload_product
      expect(STDIN).to have_received(:gets).twice
    end
  end
end
