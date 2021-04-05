
class Train

  attr_reader :train_number,:train_type,:wagon_sum

  def initialize(train_number,train_type,wagon_sum)
    @train_number = train_number
    @train_type = train_type
    @wagon_sum = wagon_sum
  end

  def add_speed

  end

  def get_current_speed

  end

  def slow_down

  end

  def get_wagon_sum
    @wagon_sum
  end

  def edit_wagon_sum(num)
    if @train_speed == 0
    @wagon_sum =+ 1
    else
      puts "PLz stop the train to unhook wagon"
    end
  end

  def add_route

  end

end