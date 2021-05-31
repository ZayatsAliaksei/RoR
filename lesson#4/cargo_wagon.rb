class CargoWagon < Wagon

  attr_reader :taken_volume,:value

  def initialize(number,load)
    super(:cargo,number)
    @value = load
    @taken_volume = 0
  end

  def take_volume(taken)
    if value > 0
       @taken_volume += taken
       false if free_spaces < 0
    else
      false
    end
  end

  def free_spaces
    value - taken_volume
  end

end
