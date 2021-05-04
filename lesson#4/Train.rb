require_relative 'Manufacturer'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :train_number, :train_type, :route, :speed, :current_route

  @@trains = {}

  def initialize(train_number, train_type)
    @train_number = train_number
    @train_type = train_type
    @wagons = []
    @speed = 0
    @@trains[train_number] = self
  end

  def self.trains_list
    @@trains
  end

  def self.get_train(train_number)
    @@trains[train_number]
  end

  def add_speed(add_speed)
    @speed += add_speed
  end

  def slow_down(minus_speed)
    @speed -= minus_speed
  end

  def unhook_wagon
    if @train_speed == 0
       @wagons > 0 ? @wagons.pop : "No more wagon"
    else
      puts "PLz stop the train to unhook wagon"
    end
  end

  def hook_ap_wagon(wagon)
    if @train_speed == 0 && wagon.type == self.train_type
      @wagons << wagon
    else
      puts "PLz stop the train to hook_ap wagon or check wagon type"
    end
  end

  def add_route(route)
    @current_route = route
    @index = 0
    edit_current_station
  end

  def to_next_station
    if not_last?
      @index += 1
      edit_current_station
    else
      puts "You are in last station"
    end
  end

  def to_previous_station
    if not_first?
      @index -= 1
      edit_current_station
    else
      puts "You are in first station"
    end
  end

  def not_last?
    @current_station != @current_route.all_stations.last
  end

  def not_first?
    @current_station[@index] != @current_route.all_stations.first
  end

  def current_station
    @current_station.name
  end

  def edit_current_station
    @current_station = @current_route.all_stations[@index]
    @current_station.get_train(self)
  end
  #нет методов которые требуют сокрытия извне
end

