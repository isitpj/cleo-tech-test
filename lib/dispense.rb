class Dispense
  attr_reader :printer, :selection, :merchandise, :change, :change_due

  def initialize(selection, merchandise, change)
    @printer = Printer.new
    @selection = selection
    @merchandise = merchandise
    @change = change
    @change_due = nil
  end
end
