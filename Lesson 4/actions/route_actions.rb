require_relative '../managers/routes_manager'
require_relative '../managers/stations_manager'
require_relative '../helpers/ui_helpers'
def route_actions(routes_manager, stations_manager)
  route_menu = Menu.new(
    {
      1 => 'Создать маршрут',
      2 => 'Добавить станцию к маршруту',
      3 => 'Удалить станцию из маршрута',
      4 => 'Просмотреть список всех маршрутов',
      5 => 'Удалить маршрут',
      0 => 'Вернуться'
    }
  )
  loop do
    route_menu.display
    choice = route_menu.get_choice
    break if choice.nil?

    case choice
    when 1
      routes_manager.list
      create_route(stations_manager, routes_manager)
    when 2
      routes_manager.list
      add_station(routes_manager, stations_manager)
    when 3
      routes_manager.list
      remove_station(routes_manager, stations_manager)
    when 4
      routes_manager.list
    when 5
      route_index = UIHelpers.get_user_input('Введите номер маршрута для удаления:').to_i
      routes_manager.delete(route_index)
    when 0
      break
    else
      puts UIHelpers.red('Something went wrong!')
    end
  end
end

def create_route(stations_manager, routes_manager)
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  start_station_name = UIHelpers.get_user_input('Введите имя начальной станции:')
  end_station_name = UIHelpers.get_user_input('Введите имя конечной станции:')
  start_station = stations_manager.find_or_create(start_station_name)
  end_station = stations_manager.find_or_create(end_station_name)
  if start_station && end_station
    routes_manager.create(start_station, end_station)
  else
    puts UIHelpers.red('Одна из станций не существует и не была создана.')
  end
end

def add_station(routes_manager, stations_manager)
  routes_manager.list
  route_index = UIHelpers.get_user_input('Введите индекс маршрута').to_i
  route = routes_manager.get_route(route_index)

  if route.nil?
    puts UIHelpers.red("Маршрут с индексом #{route_index} не найден.")
    return
  end
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  name = UIHelpers.get_user_input('Введите название станции:')
  station = stations_manager.find_or_create(name)
  if station.nil?
    puts UIHelpers.red('Не удалось создать станцию. Операция отменена.')
    return
  end

  index = UIHelpers.get_user_input('Введите порядковый номер станции на маршруте:').to_i
  if index <= 0 || index >= route.stations_list.length
    puts UIHelpers.red("Недопустимый индекс. Выберите индекс между 1 и #{route.stations_list.length - 1}.")
    return
  end
  routes_manager.add_station(route, station, index)
end

def remove_station(routes_manager, stations_manager)
  routes_manager.list
  route_index = UIHelpers.get_user_input('Введите индекс маршрута').to_i
  route = routes_manager.get_route(route_index)

  if route.nil?
    puts UIHelpers.red("Маршрут с индексом #{route_index} не найден.")
    return
  end
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  name = UIHelpers.get_user_input('Введите название станции:')
  station = route.stations_list.find { |s| s.name == name }
  if station
    route.remove_station(station)
    puts UIHelpers.green("Станция #{name} успешно удалена из маршрута.")
    true
  else
    puts UIHelpers.red("Станция с названием #{name} не найдена в маршруте.")
    false
  end
end
