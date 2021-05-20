require_relative 'instance_counter'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Menu

  def choice
    # binding.irb
    puts "Меню выбора действий"
    puts "Введите: \n
    0 - если хотите создать поезд \n
    1 - Создать станцию \n
    2 - Создать машртут или управлять станциями маршрута \n
    3 - Назначить маршрут поезду\n
    4 - Добавить вагоны к поезду\n
    5 - Отцепить вагоны от поезда\n
    6 - Перемещать поезд по маршруту\n
    7 - Просмотреть список станций и поездов на станции\n
    8 - Seed fake data!!!(Поезда(4),Станции(5),Маршруты(2)"
    start_program(gets.chop.to_i)
  end

  def start_program(input)
    case input
    when 1
      create_station
    when 2
      create_and_manage_route
    when 3
      set_route_to_train
    when 4
      add_wagon_to_train
    when 5
      delete_wagon_from_train
    when 6
      move_train
    when 7
      train_and_route_list
    when 8
      seed_fake
    when 0
      create_train
    else
      choice
    end
  end

  def create_train
    begin
    puts "Укажи тип поезда 1 - Пассажирскй | 2 - Грузовой"
    train = gets.chop.to_i
    if train == 1
      puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
      number = gets.chop
      train = PassengerTrain.new(number)
      puts "Поезд создан:\nномер - #{train.train_number}\nтип - #{train.train_type}"
      sleep(3)
    elsif train == 2
      puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
      number = gets.chop
      train = CargoTrain.new(number)
      puts "Поезд создан:\nномер - #{train.train_number} \n тип - #{train.train_type}"
      sleep(3)
    end
    rescue RuntimeError => e
      puts e.message
      retry
    end
    choice
  end

  def create_station
    begin
    puts 'Укажите название станции - '
    station = Station.new(gets.chop)
    puts "Станция создана:\nназвание - #{station.name}\n"
    sleep(3)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    choice
  end

  def create_and_manage_route
    puts "Если хотите создать маршрут выберите - 1\nЕсли хотите редактировать маршрут выберите - 2"
    gets.chop.to_i == 1 ? create_route : manage_route
  end

  def create_route
    begin
    puts "Введите названи маршрута:"
    name = gets.chop.to_s
    puts "Для создания маршрута введите название первой станции :"
    first_station = take_station(gets.chop.to_s)
    puts "Для завершения создания маршрута введите название второй станции :"
    second_station = take_station(gets.chop.to_s)
    route = Route.new(name, first_station, second_station)
    puts "Маршрут создан #{route.name}"
    rescue RuntimeError => e
      puts e.message
      retry
    end
    choice
  end

  def manage_route
    puts "Введите название маршрута который будем редактировать:"
    route_name = gets.chop.to_s
    puts "Если хотите удалить станцию выберите - 1, если добавить станцию - 2"
    var = gets.chop.to_i
    if var == 1
      puts "Введите название станции которую хотите удалить"
      station_name = take_station(gets.chop.to_s)
      route = Route.get_route(route_name)
      route.delete_station(station_name)
    elsif var == 2
      puts "Введите название станции которую хотите добавить"
      station_name = take_station(gets.chop.to_s)
      route = Route.get_route(route_name)
      route.add_station(station_name)
    end
    choice
  end

  def set_route_to_train
    puts "Введите норме поезда для которого укажем маршрут"
    train = take_train(gets.chop)
    puts "Укажите название маршрута по которому будет следовать поезд:"
    route = Route.get_route(gets.chop.text)
    train.add_route(route)
    choice
  end

  def add_wagon_to_train
    puts "Укажите номер поезда к которму добавим вагон"
    train = take_train(gets.chop)
    train_type = train.train_type
    train_type == 'cargo' ? train.add_wagon(CargoWagon.new) : train.add_wagon(PassengerWagon.new)
    choice
  end

  def delete_wagon_from_train
    puts "Укажите номер поезда от которого отцепим вагон"
    train = take_train(gets.chop)
    train.unhook_wagon
    choice
  end

  def move_train
    puts "Укажите номер поезда который будем перемещать по маршруту"
    train = take_train(gets.chop)
    puts "Если едем вперед укажите 1 если назад 2"
    gets.chop.to_i == 1 ? train.to_next_station : train.to_previous_station
    choice
  end

  def train_and_route_list
    puts "Список доступный станций:"
    Station.all.each_key { |name| puts name }
    puts "Введите название станции на которой хотите провреить поезда:"
    Station.find(gets.chop.to_s).get_trains_list
    choice
  end

  #для более удобнрой проверки
  def seed_fake
    puts "Создание станций: A,B,C,D,E"
    @a = Station.new('A')
    @b = Station.new('B')
    @c = Station.new('C')
    @d = Station.new('D')
    @e = Station.new('E')
    puts Station.all
    sleep(2)
    puts "Создание поездов - 12311(cargo),12312(cargo),12313(pass),12314(pass)"
    @train_11 = Train.new("12311", "cargo")
    @train_12 = Train.new("12312", 'cargo')
    @train_13 = Train.new("12313", 'passenger')
    @train_14 = Train.new("12314", 'passenger')
    puts Train.trains_list
    sleep(2)
    puts "Создание Маршрутов: way(A,E); road(A,B),"
    @way = Route.new('way', @a, @e)
    @road = Route.new('road', @a, @b)
    Route.all
    binding.irb
    choice
  end

  def take_train(number)
    Train.find(number)
  end

  def take_station(name)
    Station.find(name)
  end

end

Menu.new.choice