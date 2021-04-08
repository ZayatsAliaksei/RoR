class Route
  attr_reader :first_station, :last_statiom

  def initialize(first_station, last_station)
    @all_station[0] = station.new(first_station)
    @all_station << station.new(last_station)
  end

  def add_station(station)
    @all_station.insert(-2,station.new(station))
  end

  def delete_station(station)
    @all_station.delete(station)
  end

  def view_stations
    @all_station.each { |station| puts "#{station.name}" }
  end

  def get_all_stations
    @all_station
  end

end