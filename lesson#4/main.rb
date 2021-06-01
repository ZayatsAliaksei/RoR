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
    puts 'Меню выбора действий'
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
    9 - Просмотр списка поездов на станции и вагонов \n
    10 - Seed fake data!!!(Поезда(4),Станции(5),Маршруты(2)\n"
    start_program(gets.chomp.to_i)
  end

  def start_program(input)
    case input
    when 1 then create_station
    when 2 then create_and_manage_route
    when 3 then set_route_to_train
    when 4 then add_wagon_to_train
    when 5 then delete_wagon_from_train
    when 6 then move_train
    when 7 then train_and_route_list
    when 8 then manage_wagon
    when 9 then train_on_station
    when 10 then seed_fake
    when 0 then create_train
    else
      choice
    end
  end

  def create_train
    begin
      puts 'Укажи тип поезда 1 - Пассажирскй | 2 - Грузовой'
      train = gets.chomp.to_i
      case train
      when 1
        puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис
          (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
        number = gets.chomp
        train = PassengerTrain.new(number)
        puts "Поезд создан:\nномер - #{train.train_number}\nтип - #{train.train_type}"
        sleep(3)
      when 2
        puts 'Укажите номер поезда в формате - три буквы или цифры в любом порядке, необязательный дефис
         (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
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
      puts 'Введите названи маршрута:'
      name = gets.chomp.to_s
      puts 'Для создания маршрута введите название первой станции :'
      first_station = take_station(gets.chomp.to_s)
      puts 'Для завершения создания маршрута введите название второй станции :'
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
    puts 'Введите название маршрута который будем редактировать:'
    route_name = gets.chomp.to_s
    puts 'Если хотите удалить станцию выберите - 1, если добавить станцию - 2'
    var = gets.chomp.to_i
    case var
    when 1
      puts 'Введите название станции которую хотите удалить'
      station_name = take_station(gets.chomp.to_s)
      route = Route.get_route(route_name)
      route.delete_station(station_name)
    when 2
      puts 'Введите название станции которую хотите добавить'
      station_name = take_station(gets.chomp.to_s)
      route = Route.get_route(route_name)
      route.add_station(station_name)
    else
      choice
    end
  end

  def set_route_to_train
    puts 'Введите норме поезда для которого укажем маршрут'
    train = take_train(gets.chomp)
    puts 'Укажите название маршрута по которому будет следовать поезд:'
    route = Route.get_route(gets.chop.text)
    train.add_route(route)
    choice
  end

  def add_wagon_to_train
    puts 'Укажите номер поезда к которму добавим вагон'
    train = take_train(gets.chomp)
    train_type = train.train_type
    puts 'Укажите количество мест(если поезд пассажирский) или обьем вагона(если поезд грузовой)'
    count = gets.to_i
    train_type == :cargo ? train.add_wagon(CargoWagon.new(10, count)) : train.add_wagon(PassengerWagon.new(10, count))
    choice
  end

  def delete_wagon_from_train
    puts 'Укажите номер поезда от которого отцепим вагон'
    train = take_train(gets.chomp)
    train.unhook_wagon
    choice
  end

  def move_train
    puts 'Укажите номер поезда который будем перемещать по маршруту'
    train = take_train(gets.chomp)
    puts 'Если едем вперед укажите 1 если назад 2'
    train_departure(train)
    if gets.chop.to_i == 1
      train.to_next_station
    else
      train.to_previous_station
    end
    choice
  end

  def train_and_route_list
    puts 'Список доступный станций:'
    Station.all.each_key { |name| puts name }
    puts 'Введите название станции на которой хотите провреить поезда:'
    Train.trains_list.each { |train| puts "Номер:#{train[0]}" }
    choice
  end

  def manage_wagon
    puts 'Укажите номер вагона в котором хотите занять место или загрузить'
    wagon = take_wagon(gets.to_i)
    if wagon.type == 'passenger'
      wagon.take_seat
    else
      puts "В вагоне свободно #{wagon.free_spaces},укажите сколько хотите заполнить места"
      wagon.take_volume(gets.to_i)
    end
    choice
  end

  def train_on_station
    Station.all { |station| puts "#{station[0]} \n"; station[1].get_trains_list; station[1].trains.each { |train| info_ab_train_wagon(train) } }
    choice
  end

  def info_ab_train_wagon(train)
    train.train_wagons { |wagon| puts "Номер вагона#{wagon.number}:, тип вагона:#{wagon.type},свободно:#{wagon.value} / занято #{wagon.taken_value}" }
  end

  def seed_fake
    @st1 = Station.new('A')
    @st2 = Station.new('B')
    @st3 = Station.new('C')
    @st4 = Station.new('D')
    @st5 = Station.new('E')
    @train11 = Train.new('123-11', :cargo)
    @train12 = Train.new('123-12', :passenger)
    @way = Route.new('way', @st1, @st5)
    @way.add_station(@st2)
    @way.add_station(@st3)
    @way.add_station(@st4)
    @road = Route.new('road', @st1, @st2)
    @pass_wagon1 = PassengerWagon.new(1, 10)
    @pass_wagon2 = PassengerWagon.new(2, 20)
    @cargo_wagon3 = CargoWagon.new(3, 30)
    @cargo_wagon4 = CargoWagon.new(4, 40)
    @train11.hook_ap_wagon(@cargo_wagon3)
    @train11.hook_ap_wagon(@cargo_wagon4)
    @train12.hook_ap_wagon(@pass_wagon1)
    @train12.hook_ap_wagon(@pass_wagon2)
    @train11.add_route(@way)
    @train12.add_route(@road)
    train_departure(@train11)
    @train11.to_next_station
    train_departure(@train12)
    @train12.to_next_station
    puts "Созданы станции: A,B,C,D,E; \n
    Поезда: 123-11 Грузовой, 123-12 Пассажирский \n
    Маршрут way c начальными станциями А-Е, к нему через метод добавлены станции В С D \n
    Маршрут road c начальными станциями А-В \n
    Созданы вагоны: Пассажирские №1 - 10 мест , №2 - 20 мест; Грузовые №3- 30 обьем, №4 - 40 обьем \n
    Вагоны 1 и 2 прицеплены к поезду №123-12, вагоны 3 и 4 к поезду №123-11 \n
    Поезда перемещены на станцию вперед
    "
    sleep(1)
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

  def train_departure(train)
    train.current_station.send_train(train)
  end
end

Menu.new.choice
