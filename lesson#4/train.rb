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
    @current_route = route.get_all_stations
    @index = 0
    @current_station = @current_route[@index]
  end

  def to_next_station
    if not_last?
      @index += 1
      @current_station = @current_route[@index]
    else
      puts "The last station"
    end
  end

  def to_previous_station
    if not_first?
      @index -= 1
      @current_station = @current_route[@index]
    else
      puts "The first station"
    end
  end

  def view_close_route
    if not_last? && not_first?
      puts "prev.station is:#{@current_route[@index - 1]} current station is:#{@current_route[@index]} next station is:#{@current_route[@index + 1]}"
    elsif !not_last?
      puts "prev.station is:#{@current_route[@index - 1]} current station is:#{@current_route[@index]},station is last}"
    elsif !not_first?
      puts "current station is first:#{@current_route[@index]},next station is:#{@current_route[@index + 1]}"
    end
  end

  def not_last?
    @current_route[@index] != @current_route.last
  end

  def not_first?
    @current_route[@index] != @current_route.first
  end
end