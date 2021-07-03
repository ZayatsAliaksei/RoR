require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :first_station, :last_station, :name, :all_stations

  validate :name,:presence
  @@routes = {}
  def initialize(name, first_station, last_station)
    @name = name
    @all_stations = []
    @all_stations[0] = first_station
    @all_stations << last_station
    @@routes[name] = self
    self.register_instance
    validate!
  end

  def self.all
    @@routes
  end

  def self.get_route(name)
    @@routes[name]
  end

  def add_station(station)
    @all_stations.insert(-2, station)
  end

  def delete_station(station)
    @all_stations.delete_if { |obj| obj == station }
  end

  def view_stations
    all_stations.each { |station| puts station.name.to_s }
  end

  # def validate!
  #   raise 'Необходимо название для маршрута' if @name.nil?
  #
  #   true
  # end
  #
  # def valid?
  #   validate!
  # rescue StandardError
  #   false
  # end
end
