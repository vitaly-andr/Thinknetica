require_relative '../helpers/ui_helpers'
require_relative '../menu'
require_relative '../managers/trains_manager'
require_relative '../managers/rail_car_manager'
require_relative '../managers/routes_manager'

def create_train(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер нового поезда:')
  train_manufacturer = UIHelpers.get_user_input('Введите производителя')
  train_type = UIHelpers.get_user_input("Введите тип поезда (#{TrainsManager::ALLOWED_TYPES.join('/')}):")
  train_manager.create(train_number, train_type, train_manufacturer)
end

def delete_train(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для удаления:')
  train_manager.delete(train_number)
end

def remove_car_from_train(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для отцепления вагона:')
  train_manager.remove_car(train_number)
end

def assign_route_to_train(routes_manager, train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для назначения маршрута:')
  routes_manager.list
  route_index = UIHelpers.get_user_input('Введите индекс маршрута:').to_i
  route = routes_manager.get_route(route_index)
  train_manager.assign_route(train_number, route)
end

def move_train_forward(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для перемещения вперед по маршруту:')
  train_manager.move_forward(train_number)
end

def move_train_backward(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для перемещения назад по маршруту:')
  train_manager.move_backward(train_number)
end

def show_list_of_trains(train_manager)
  puts UIHelpers.green('Список всех поездов:')
  train_manager.list
end

def set_trains_speed(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда для установки скорости:')
  train_speed = UIHelpers.get_user_input('Введите скорость:').to_i
  train_manager.set_speed(train_number, train_speed)
end

def stop_train(train_manager)
  train_number = UIHelpers.get_user_input('Введите номер поезда, который остановить:')
  train_manager.brake(train_number)
end

def train_actions(train_manager, rail_car_manager, routes_manager)
  train_menu = Menu.new(
    {
      1 => 'Создать поезд',
      2 => 'Удалить поезд',
      3 => 'Прицепить вагон к поезду',
      4 => 'Отцепить вагон от поезда',
      5 => 'Назначить маршрут поезду',
      6 => 'Переместить поезд вперед по маршруту',
      7 => 'Переместить поезд назад по маршруту',
      8 => 'Просмотреть список всех поездов',
      9 => 'Установить скорость поезда',
      10 => 'Остановить поезд',
      0 => 'Вернуться в главное меню'
    }
  )
  loop do
    train_menu.display
    choice = train_menu.get_choice
    next if choice.nil?

    menu_options_requiring_train_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    show_list_of_trains(train_manager) if menu_options_requiring_train_list.include?(choice)

    case choice
    when 1
      create_train(train_manager)
    when 2
      delete_train(train_manager)
    when 3
      add_car_to_train(train_manager, rail_car_manager)
    when 4
      remove_car_from_train(train_manager)
    when 5
      assign_route_to_train(routes_manager, train_manager)
    when 6
      move_train_forward(train_manager)
    when 7
      move_train_backward(train_manager)
    when 8
      # Пункт 8 теперь просто показывает список поездов
    when 9
      set_trains_speed(train_manager)
    when 10
      stop_train(train_manager)
    when 0
      break
    else
      puts UIHelpers.red('Something went wrong.')
    end
  end
end

def add_car_to_train(train_manager, rail_car_manager)
  number = UIHelpers.get_user_input('Введите номер поезда:')

  puts "Выберите вагон для добавления к поезду #{number}:"
  available_cars = rail_car_manager.list_cars(free_filter: true)
  puts UIHelpers.green('Свободные вагоны')
  available_cars.each_with_index do |car, index|
    puts UIHelpers.green("#{index + 1}. Вагон №#{car.car_number} типа #{car.class}")
  end
  car_index = UIHelpers.get_user_input('Введите порядковый номер вагона:').to_i - 1
  car = available_cars[car_index]

  if car
    train_manager.add_car(number, car)
  else
    puts UIHelpers.red('Некорректный выбор.')
  end
end
