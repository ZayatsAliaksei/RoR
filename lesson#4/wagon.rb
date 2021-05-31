require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type, :number
  @@wagons = {}

  def initialize(type, number,value)
    @type = type
    @number = number
    @@wagons[number] = self
    @value = value
    @taken_value = 0
  end

  def self.wagon_list
    @@wagons
  end

  def self.find(wagon_number)
    @@wagons[wagon_number]
  end

  def taken_value
    if value > 0
      self.taken_value += 1
      @value -= 1
    else
      false
    end
  end

  protected
  attr_reader :taken_value,:value

end
