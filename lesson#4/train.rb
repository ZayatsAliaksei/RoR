class Train
  attr_reader :train_number, :train_type, :wagon_sum, :route
  attr_accessor :speed, :current_station, :current_route

  def initialize(train_number, train_type, wagon_sum)
    @train_number = train_number
    @train_type = train_type
    @wagon_sum = wagon_sum
    @speed = 0
  end

  def add_speed(add_speed)
    @speed += add_speed
  end

  def get_current_speed
    @speed
  end

  def slow_down(minus_speed)
    @speed -= minus_speed
  end

  def get_wagon_sum
    @wagon_sum
  end

  def unhook_wagon
    if @train_speed == 0
      @wagon_sum -= 1 if @wagon_sum > 0
    else
      puts "PLz stop the train to unhook wagon"
    end
  end

  def hook_ap_wagon
    if @train_speed == 0
      @wagon_sum += 1
    else
      puts "PLz stop the train to hook_ap wagon"
    end
  end

  def add_route(route)
    @current_route = route.new(first_station,last_station)
    @index = 0
    current_route
  end

  def to_next_station
    if not_last?
      @index += 1
      current_route
    else
      puts "The last station"
    end
  end

  def to_previous_station
    if not_first?
      @index -= 1
      current_route
    else
      puts "The first station"
    end
  end

  def next_station
    @current_route[@index + 1] != nil ? @current_route[@index + 1] : puts "Last station"
    #@index - 1
  end

  def previous_station
    @index >= 0 ? @current_route[@index - 1] : puts "First station"
    #@index + 1
  end

  def not_last?
    current_route != @current_route.last
  end

  def not_first?
    current_route != @current_route.first
  end

  def current_route
    @current_route[@index]
  end
end
