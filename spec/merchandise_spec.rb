require 'merchandise'

describe Merchandise do
  describe '#initialize' do
    it 'has a products attribute that is an array' do
      merchandise = Merchandise.new
      expect(merchandise.products).to be_an(Array)
    end
  end
end
