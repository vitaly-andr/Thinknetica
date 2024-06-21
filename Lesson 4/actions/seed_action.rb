class SeedAction
  def seed(trains_manager, rail_car_manager, routes_manager, stations_manager)
    # Создание поездов с корректными номерами
    5.times do |i|
      passenger_number = format("%03d-%02d", rand(100..999), rand(10..99))
      cargo_number = format("%03d-%02d", rand(100..999), rand(10..99))
      trains_manager.create(passenger_number, 'passenger', "Passenger Manufacturer #{i+1}")
      trains_manager.create(cargo_number, 'cargo', "Cargo Manufacturer #{i+1}")
    end

    # Создание вагонов с корректными номерами
    5.times do |i|
      passenger_car_number = format("%03d-%02d", rand(100..999), rand(10..99))
      cargo_car_number = format("%03d-%02d", rand(100..999), rand(10..99))
      rail_car_manager.create('passenger', passenger_car_number, "Car Manufacturer #{i+1}")
      rail_car_manager.create('cargo', cargo_car_number, "Car Manufacturer #{i+1}")
    end

    # Прицепление вагонов к поездам
    all_trains = PassengerTrain.all + CargoTrain.all
    all_trains.each do |train|
      puts "Обработка поезда №#{train.number}, тип: #{train.class}"
      3.times do |i|
        # Выбор вагона в зависимости от типа поезда
        available_cars = (train.is_a?(PassengerTrain) ? PassengerCar.all : CargoCar.all)

        # Фильтрация только свободных вагонов
        free_cars = available_cars.select { |car| car.attached_to.nil? }

        puts "Найдено #{free_cars.count} свободных вагонов для #{train.is_a?(PassengerTrain) ? 'пассажирского' : 'грузового'} поезда."

        # Проверка наличия свободных вагонов
        if free_cars.any?
          train.add_car(free_cars.first)  # Добавляем первый свободный вагон
          puts "Вагон №#{free_cars.first.car_number} прицеплен к поезду №#{train.number}."
        else
          puts "Нет свободных вагонов для поезда №#{train.number}. Процесс добавления вагонов остановлен."
          break  # Прерываем цикл, если свободные вагоны закончились
        end
      end
    end

    # Создание станций
    9.times do |i|
      stations_manager.create("Station #{i+1}")
    end

    # Создание маршрутов
    5.times do |i|
      start_index = i * 2 + 1
      end_index = i * 2 + 3
      routes_manager.create(stations_manager.find_or_create("Station #{start_index}"), stations_manager.find_or_create("Station #{end_index}"))
    end

    # Используем список маршрутов, чтобы добавить промежуточные станции
    Route.all.each_with_index do |route, index|
      middle_index = index * 2 + 2
      middle_station = stations_manager.find_or_create("Station #{middle_index}")
      route.add_station(middle_station, 1) if middle_station
    end
  end
end
