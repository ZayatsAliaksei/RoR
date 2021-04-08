class Route
  attr_reader :first_station, :last_statiom

  def initialize(first_station, last_station)
    @all_stations[0] = station.new(first_station)
    @all_stations << station.new(last_station)
  end

  def add_station(station)
    @all_stations.insert(-2,station.new(station))
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

  def view_stations
    @all_stations.each { |station| puts "#{station.name}" }
  end

  def get_all_stations
    @all_stations
  end

end
