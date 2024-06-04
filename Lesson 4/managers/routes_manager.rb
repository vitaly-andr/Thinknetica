# managers/routes_manager.rb
require_relative '../entities/route'

class RoutesManager
  def initialize
    @routes = []
  end

  def create(start_station, end_station)
    route = Route.new(start_station, end_station)
    @routes << route
    puts UIHelpers.green("Маршрут от станции '#{start_station.name}' до станции '#{end_station.name}' успешно создан.")
  end

  def get_route(index)
    @routes[index] if index >= 0 && index < @routes.size
  end

  def delete(index)
    if index >= 0 && index < @routes.length
      @routes.delete_at(index)
      puts UIHelpers.green("Маршрут с индексом #{index} был удален.")
    else
      puts UIHelpers.red('Маршрут с таким индексом не найден.')
    end
  end

  def add_station(route, station, index)
    if index <= 0 || index >= route.stations_list.length
      puts UIHelpers.red("Недопустимый индекс. Индекс должен быть между 1 и #{route.stations_list.length - 1}.")
    else
      route.add_station(station, index)
      puts UIHelpers.green("Станция #{station.name} добавлена в маршрут.")
    end
  end

  def remove_station(route, station)
    if route.stations_list.length <= 2
      puts UIHelpers.red('Невозможно удалить станцию. В маршруте должно быть минимум две станции.')
    else
      route.remove_station(station)
      puts UIHelpers.green("Станция #{station.name} удалена из маршрута.")
    end
  end

  def list
    puts UIHelpers.green('Список маршрутов')
    @routes.each_with_index do |route, index|
      puts UIHelpers.green("#{index}: #{route.stations_list.map(&:name).join(' -> ')}")
    end
  end

  def get_stations_list(route_index)
    route = @routes[route_index]
    if route
      route.stations_list.each_with_index do |station, index|
        puts UIHelpers.green("#{index}: #{station.name}")
      end
    else
      puts UIHelpers.red('Некорректный индекс')
    end
  end

  def get_station(route_index, station_index)
    @routes[route_index].stations_list[station_index]
  end
end