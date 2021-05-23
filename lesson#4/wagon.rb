require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type, :number
  @@wagons = {}

  def initialize(type, number)
    @type = type
    @number = number
    @@wagons[number] = self
  end

  def self.wagon_list
    @@wagons
  end

  def self.find(wagon_number)
    @@wagons[wagon_number]
  end

end
