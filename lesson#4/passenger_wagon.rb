class PassengerWagon < Wagon
  @@wagon_number = 0
  def initialize
    super(passenger)
    @@wagon_number += 1
  end
end