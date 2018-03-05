require 'change'

describe Change do
  describe '#initialize' do
    it 'has a coins attribute that is an array' do
      change = Change.new
      expect(change.coins).to be_an(Array)
    end
  end
end
