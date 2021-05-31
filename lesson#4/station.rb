class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    self.register_instance
    validate!
  end

  def self.all
    @@stations.each { |station| yield(station) }
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

  def delete_train(train)
    @trains.delete_if {|obj| obj == train}
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
      if train_type == "cargo"
        sum_cargo += 1
      else
        sum_passenger += 1
      end
    end

    type_sum = {
      sum_cargo => "cargo",
      sum_passenger => "passenger"
    }
    type_sum.each { |sum, type| puts "#{sum} -- #{type}" }
  end

  def send_train(went_train)
    trains.delete(went_train)
  end

  def validate!
    raise "Необходимо название для станции" if @name.empty?
    true
  end

  def valid?
    validate!
  rescue
    false
  end

end
