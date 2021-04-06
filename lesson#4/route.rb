class Route

  attr_reader :first_station,:last_statiom

  def initialize(first_station,last_station,midle_station = nil)
    @first_station = first_station
    @last_station = last_station
    @midle_stations = []
    @midle_stations<<midle_station
  end

  def add_station(station)
    @midle_stations<<station
  end

  def delete_station(station)
    @midle_stations.delete(station)
  end

  def view_station
    puts @first_station
    all_station.each{|name_station| puts "#{name_station}"}
    puts @last_statiom
  end

  def get_all_station
    all_station = @midle_stations
    all_station.insert(0,@first_station)
    all_station.insert(-1,@last_statiom)
    all_station
  end

end