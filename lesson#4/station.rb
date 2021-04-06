class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @train = {}
  end

  def get_train(arrival_train)
    @train<<arrival_train
  end

  def get_train_list
    @train.each{|train,type| puts "#{train} => #{type}"}
  end

  def get_train_type_list
    sum_1  = 0
    sum_2  = 0

    @train.each_value do |train_type|
      if train_type == "грузовой"
        sum_1+=1
      else
        sum_2+=1
      end
    end

    type_sum = {
      sum_1 => "грузовой",
      sum_2 => "пассажирский"
    }

    type_sum.each{|sum,type| puts "#{sum} -- #{type}"}
  end

  def send_train(went_train)
    @train.delete(went_train)
  end
end