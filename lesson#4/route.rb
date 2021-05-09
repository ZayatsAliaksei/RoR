class Route
  include InstanceCounter
  attr_reader :first_station, :last_station, :name, :all_stations

  @@routes = {}
  def initialize(name,first_station, last_station)
    @name = name
    @all_stations = []
    @all_stations[0] = first_station
    @all_stations << last_station
    @@routes[name] = self
    self.register_instance
  end

  def self.routs_list
    @@routes
  end

  def self.get_route(name)
    @@routes[name]
  end

  def add_station(station)
    @all_stations.insert(-2,station)
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

  def view_stations
    @all_stations.each { |station| puts "#{station.name}" }
  end
end
