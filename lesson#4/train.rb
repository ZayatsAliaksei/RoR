require_relative 'manufacturer'
require_relative 'validation'
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  attr_reader :train_number, :train_type, :route, :current_route, :wagons, :current_station

  NUMBER_FORMAT = /^[а-я0-9]{3}-*[а-я0-9]{2}$/i.freeze

  validate :train_number, :presence
  validate :train_number, :format, NUMBER_FORMAT
  @@trains = {}

  def initialize(train_number, train_type)
    @train_number = train_number
    @train_type = train_type
    @wagons = []
    @speed = 0
    @@trains[train_number] = self
    register_instance
    validate!
  end

  def self.trains_list
    @@trains
  end

  def self.find(train_number)
    @@trains[train_number]
  end

  def add_speed(add_speed)
    self.speed += add_speed
  end

  def slow_down(minus_speed)
    self.speed -= minus_speed
  end

  def unhook_wagon
    @wagons.pop if @speed != 0 && @wagons.count.positive?
  end

  def hook_ap_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == train_type
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
    end
  end

  def to_previous_station
    if not_first? && not_last?
      @index -= 1
      edit_current_station
    end
  end

  def not_last?
    @current_station != @current_route.all_stations.last
  end

  def not_first?
    @current_station[@index] != @current_route.all_stations.first
  end

  def edit_current_station
    @current_station = @current_route.all_stations[@index]
    @current_station.get_train(self)
  end

  def train_wagons(&block)
    @wagons.each(&block) if block_given?
  end

  protected

  attr_writer :speed

  # def validate!
  #   raise 'Номер не может быть пустым!' if @train_number.empty?
  #   raise 'Номер не соотвествует формату ' if @train_number !~ NUMBER_FORMAT
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
