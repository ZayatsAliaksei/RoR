class CargoWagon < Wagon
  @@wagon_number = 0
  def initialize
    super(cargo)
    @@wagon_number += 1
  end
end