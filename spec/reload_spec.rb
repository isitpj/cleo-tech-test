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
    end

    it 'calls the Printer class\'s #print_reload_options method' do
      printer = spy('printer')
      allow(Printer).to receive(:new) { printer }
      reload.assign_product_or_change
      expect(printer).to have_received(:print_reload_options)
    end

    it 'calls gets to receive user input' do
      reload.assign_product_or_change
      expect(STDIN).to have_received(:gets)
    end

    xit 'calls #reload_coin' do

    end
  end

  describe '#reload_coin' do
    it 'prints three statements to the user' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('100', '5' )
      reload.reload_coin
      expect(STDOUT).to have_received(:puts).exactly(3).times
    end

    it 'gets user input twice' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return('100', '5' )
      reload.reload_coin
      expect(STDIN).to have_received(:gets).twice
    end
  end
end
