require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  validate :name, :presence
  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    self.register_instance
    validate!
  end

  def self.all
    @@stations.each_key { |station| yield(station) }
  end

  def self.find(name)
    @@stations[name].nil? ? false : @@stations[name]
  end

  def self.trains_on_station
    if block_given?
      @@stations.each { |train| yield(train) }
    end
  end

  def get_train(arrival_train)
    @trains << arrival_train
  end

  def send_train(train)
    @trains.delete_if { |obj| obj == train }
  end

  def get_trains_list
    trains.each { |train| puts "Номер поезда:#{train.train_number}// Тип:#{train.train_type}//Вагонов:#{train.wagons.count}" }
  end

  def trains_on_station
    if block_given?
      trains.each { |train| yield(train) }
    end
  end

  def get_trains_type_list
    sum_cargo = 0
    sum_passenger = 0
    trains.each do |train_type|
      train_type == :cargo ? sum_cargo += 1 : sum_passenger += 1
    end

    type_sum = {
      sum_cargo => 'cargo',
      sum_passenger => 'passenger'
    }
    type_sum.each { |sum, type| puts "#{sum} -- #{type}" }
  end

  def validate!
    raise 'Необходимо название для станции' if @name.empty?

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
