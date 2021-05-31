class PassengerWagon < Wagon

  attr_reader :taken_seats,:value

  def initialize(number,seats)
    super(:passenger,number)
    @value = seats
    @taken_seats = 0
  end

  def take_seat
    if value > 0
      self.taken_seats += 1
      @value -= 1
    else
      false
    end
  end

end
