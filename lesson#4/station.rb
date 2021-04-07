class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @train = {}
  end

  def get_train(arrival_train)
    @train << arrival_train
  end

  def get_trains_list
    @train.each { |train, type| puts "#{train} => #{type}" }
  end

  def get_trains_type_list
    sum_cargo = 0
    sum_passenger = 0
    @train.each_value do |train_type|
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
    @train.delete(went_train)
  end
end
