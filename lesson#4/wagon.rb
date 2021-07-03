require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation
  attr_reader :type, :number, :taken_value, :value

  validate :value, :presence
  validate :number, :presence

  @@wagons = {}

  def initialize(type, number, value)
    @type = type
    @number = number
    @@wagons[number] = self
    @value = value
    @taken_value = 0
    validate!
  end

  def self.wagon_list
    @@wagons
  end

  def self.find(wagon_number)
    @@wagons[wagon_number]
  end

  def takes_value
    if value > 0
      self.taken_value += 1
      @value -= 1
    else
      false
    end
  end
end
