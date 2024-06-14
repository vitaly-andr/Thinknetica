require_relative '../entities/train'
require_relative '../entities/passenger_train'
require_relative '../entities/cargo_train'
require_relative '../helpers/ui_helpers'

class TrainsManager
  ALLOWED_TYPES = %i[cargo passenger].freeze

  def create(train_number, type_str, train_manufacturer)
    type = type_str.strip.downcase.to_sym # Преобразуем введенную строку в символ
    unless ALLOWED_TYPES.include?(type)
      puts UIHelpers.red("Неверный тип поезда. Допустимые типы: #{ALLOWED_TYPES.join(', ')}.")
      return
    end
    train = find(train_number)
    if train
      puts UIHelpers.red("Поезд с номером '#{train_number}' уже существует.")
    else
      type == :passenger ? PassengerTrain.new(train_number, train_manufacturer) : CargoTrain.new(train_number, train_manufacturer)

      puts UIHelpers.green("Поезд '#{train_number}' успешно создан.")
    end
  end

  def delete(train_number)
    train = find(train_number)
    if train
      train.class.delete(train)
      puts UIHelpers.green("Поезд '#{train_number}' был удален.")
    else
      puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.")
    end
  end

  def get_route(train_number)
    train = find(train_number)
    return puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.") unless train
    return puts UIHelpers.red('Нет прикрепленного маршрута') unless train.route.is_a?(Route)

    train.route
  end

  def get_current_station(train_number)
    train = find(train_number)
    return puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.") unless train
    return print UIHelpers.red('Нет прикрепленного маршрута ') unless train.route.is_a?(Route)

    train.current_station_index
  end

  def list
    puts 'Зарегистрировано пассажирских поездов'
    puts PassengerTrain.instances
    puts 'Зарегистрировано грузовых поездов'
    puts CargoTrain.instances

    all_trains = PassengerTrain.all + CargoTrain.all # Объединяем массивы всех поездов    puts "All trains: #{all_trains.inspect}" # Отладочное сообщение

    all_trains.each do |train|
      route = train.route
      route_str = route ? route.stations_list.map(&:name).join(' -> ') : ''
      current_station_index = train.current_station_index
      current_station_name = route ? route.stations_list[current_station_index].name : ''
      puts UIHelpers.green("#{train.number} - Производитель - #{train.name} - #{train.class} скорость - #{train.speed} маршрут - #{route_str} Текущая станция - #{current_station_name}")
    end
  end

  def move_forward(train_number)
    train = find(train_number)
    if train
      begin
        train.move_forward
        puts UIHelpers.green('Поезд успешно перемещен.')
      rescue StandardError => e
        puts UIHelpers.red("Ошибка при перемщении поезда: #{e.message}")
      end
    else
      puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.")
    end
  end

  def move_backward(train_number)
    train = find(train_number)
    if train
      begin
        train.move_backward
        puts UIHelpers.green('Поезд успешно перемещен.')
      rescue StandardError => e
        puts UIHelpers.red("Ошибка при перемщении поезда: #{e.message}")
      end
    else
      puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.")
    end
  end

  def set_speed(train_number, speed)
    train = find(train_number)
    if train
      train.speed = speed
    else
      puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.")
    end
  end

  def brake(train_number)
    train = find(train_number)
    if train
      train.speed = 0
      puts UIHelpers.green("Поезд с номером '#{train_number}' остановлен.")
    else
      puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.")
    end
  end

  def add_car(train_number, car)
    train = find(train_number)
    return puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.") unless train

    begin
      train.add_car(car)
      puts UIHelpers.green("Вагон успешно прицеплен к поезду '#{train_number}'.")
    rescue StandardError => e
      puts UIHelpers.red("Ошибка при добавлении вагона: #{e.message}")
    end
  end

  def remove_car(train_number)
    train = find(train_number)
    return puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.") unless train
    return puts UIHelpers.red('У поезда нет прицепленных вагонов.') if train.cars.empty?

    puts UIHelpers.green('Список вагонов поезда')
    train.cars.each_with_index do |car, index|
      puts "#{index + 1}. Вагон №#{car.car_number} типа #{car.class}"
    end
    car_index = UIHelpers.get_user_input('Введите номер вагона для отцепления:').to_i - 1
    car = train.cars[car_index]

    if car
      begin
        train.remove_car(car)
        puts UIHelpers.green("Вагон успешно отцеплен от поезда '#{train_number}'.")
      rescue StandardError => e
        puts UIHelpers.red("Ошибка при отцеплении вагона: #{e.message}")
      end
    else
      puts UIHelpers.red('Некорректный выбор.')
    end
  end

  def assign_route(train_number, route)
    train = find(train_number)
    return puts UIHelpers.red("Поезд с номером '#{train_number}' не найден.") unless train

    train.accept_route(route)
    puts UIHelpers.green("Поезду с номером '#{train_number}' успешно назначен маршрут.")
  end

  def find(train_number)
    train = PassengerTrain.find(train_number)
    train || CargoTrain.find(train_number)

  end

end
