class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def get_train(arrival_train)
    @trains << arrival_train
  end

  def get_trains_list
    @trains.each { |train, type| puts "#{train} => #{type}" }
  end

  def get_trains_type_list
    sum_cargo = 0
    sum_passenger = 0
    @trains.each_value do |train_type|
      if train_type == "грузовой"
        sum_cargo += 1
      else
        sum_passenger += 1
      end
    end

    type_sum = {
      sum_cargo => "грузовой",
      sum_passenger => "пассажирский"
    }
    type_sum.each { |sum, type| puts "#{sum} -- #{type}" }
  end

  def send_train(went_train)
    @trains.delete(went_train)
  end
end