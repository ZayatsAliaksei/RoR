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
    7 - Просмотреть список станций и поездов\n
    8 - Управление вагоном \n
    9 - Просмотр списка поездов на станции \n
    10 - Просмотр списка вагонов у поезда \n
    11 - Seed fake data!!!(Поезда(4),Станции(5),Маршруты(2)\n"
    start_program(gets.chomp.to_i)
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
      manage_wagon
    when 9
      train_on_station
    when 10
      info_ab_train_wagon
    when 11
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
      train = gets.chomp.to_i
      if train == 1
        puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
        number = gets.chomp
        train = PassengerTrain.new(number)
        puts "Поезд создан:\nномер - #{train.train_number}\nтип - #{train.train_type}"
        sleep(3)
      elsif train == 2
        puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
        number = gets.chomp
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
      station = Station.new(gets.chomp)
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
      name = gets.chomp.to_s
      puts "Для создания маршрута введите название первой станции :"
      first_station = take_station(gets.chomp.to_s)
      puts "Для завершения создания маршрута введите название второй станции :"
      second_station = take_station(gets.chomp.to_s)
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
    route_name = gets.chomp.to_s
    puts "Если хотите удалить станцию выберите - 1, если добавить станцию - 2"
    var = gets.chomp.to_i
    if var == 1
      puts "Введите название станции которую хотите удалить"
      station_name = take_station(gets.chomp.to_s)
      route = Route.get_route(route_name)
      route.delete_station(station_name)
    elsif var == 2
      puts "Введите название станции которую хотите добавить"
      station_name = take_station(gets.chomp.to_s)
      route = Route.get_route(route_name)
      route.add_station(station_name)
    end
    choice
  end

  def set_route_to_train
    puts "Введите норме поезда для которого укажем маршрут"
    train = take_train(gets.chomp)
    puts "Укажите название маршрута по которому будет следовать поезд:"
    route = Route.get_route(gets.chop.text)
    train.add_route(route)
    choice
  end

  def add_wagon_to_train
    puts "Укажите номер поезда к которму добавим вагон"
    train = take_train(gets.chomp)
    train_type = train.train_type
    puts "Укажите количество мест(если поезд пассажирский) или обьем вагона(если поезд грузовой)"
    count = gets.to_i
    train_type == 'cargo' ? train.add_wagon(CargoWagon.new(10, count)) : train.add_wagon(PassengerWagon.new(10, count))
    choice
  end

  def delete_wagon_from_train
    puts "Укажите номер поезда от которого отцепим вагон"
    train = take_train(gets.chomp)
    train.unhook_wagon
    choice
  end

  def move_train
    puts "Укажите номер поезда который будем перемещать по маршруту"
    train = take_train(gets.chomp)
    puts "Если едем вперед укажите 1 если назад 2"
    gets.chop.to_i == 1 ? train.to_next_station : train.to_previous_station
    choice
  end

  def train_and_route_list
    puts "Список доступный станций:"
    Station.all.each_key { |name| puts name }
    puts "Введите название станции на которой хотите провреить поезда:"
    Train.trains_list.each { |train| puts "Номер:#{train.train_number}" }
    choice
  end

  def manage_wagon
    puts "Укажите номер вагона в котором хотите занять место или загрузить"
    wagon = take_wagon(gets.to_i)
    if wagon.type == "passenger"
      wagon.take_seat
    else
      puts "В вагоне свободно #{wagon.free_spaces},укажите сколько хотите заполнить места"
      wagon.take_volume(gets.to_i)
    end
    choice
  end

  def train_on_station
    puts "Укажите станцию на котороый хотите посмотреть поезда:"
    station = take_station(gets.chomp)
    station.trains_on_station { |train| puts "Номер: #{train.train_number};Тип: #{train.train_type};Количество вагонов: #{train.wagons.count}" }
    choice
  end

  def info_ab_train_wagon
    puts "Укажите поезд информацию о вагонах которого хотите получить"
    train = take_train(gets.to_s.chomp)
    train.train_wagons { |wagon| puts "Номер вагона#{wagon.number}:, тип вагона:#{wagon.type},свободных мест/пространства:#{wagon.value}" }
    choice
  end

  #для более удобнрой проверки
  def seed_fake
    @a = Station.new('A')
    @b = Station.new('B')
    @c = Station.new('C')
    @d = Station.new('D')
    @e = Station.new('E')
    @train_11 = Train.new("123-11", "cargo")
    @train_12 = Train.new("123-12", 'passenger')
    @way = Route.new('way', @a, @e)
    @way.add_station(@b)
    @way.add_station(@c)
    @way.add_station(@d)
    @road = Route.new('road', @a, @b)
    @pass_wagon1 = PassengerWagon.new(1, 10)
    @pass_wagon2 = PassengerWagon.new(2, 20)
    @cargo_wagon3 = CargoWagon.new(3, 30,)
    @cargo_wagon4 = CargoWagon.new(4, 40)
    @train_11.hook_ap_wagon(@cargo_wagon3)
    @train_11.hook_ap_wagon(@cargo_wagon4)
    @train_12.hook_ap_wagon(@pass_wagon1)
    @train_12.hook_ap_wagon(@pass_wagon2)
    @train_11.add_route(@way)
    @train_12.add_route(@road)
    @train_11.to_next_station
    @train_12.to_next_station
    puts "Созданы станции: A,B,C,D,E; \n
    Поезда: 123-11 Грузовой, 123-12 Пассажирский \n
    Маршрут way c начальными станциями А-Е, к нему через метод добавлены станции В С D \n
    Маршрут road c начальными станциями А-В \n
    Созданы вагоны: Пассажирские №1 - 10 мест , №2 - 20 мест; Грузовые №3- 30 обьем, №4 - 40 обьем \n
    Вагоны 1 и 2 прицеплены к поезду №123-12, вагоны 3 и 4 к поезду №123-11 \n
    Поезда перемещены на станцию вперед
    "
    sleep(1)
    binding.irb
    choice
  end

  def take_train(number)
    Train.find(number)
  end

  def take_station(name)
    Station.find(name)
  end

  def take_wagon(number)
    Wagon.find(number)
  end

end

Menu.new.choice