require 'reload'

describe Reload do
  describe '#assign_product_or_change' do
    it 'calls gets to receive user input' do
      reload = Reload.new
      allow(STDIN).to receive(:gets) { 'change' }
      reload.assign_product_or_change
      expect(STDIN).to have_received(:gets)
    end
  end
end
