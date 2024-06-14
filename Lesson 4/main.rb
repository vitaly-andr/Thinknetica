require_relative 'managers/stations_manager'
require_relative 'actions/station_actions'
require_relative 'managers/trains_manager'
require_relative 'actions/train_actions'
require_relative 'managers/routes_manager'
require_relative 'actions/route_actions'
require_relative 'managers/rail_car_manager'
require_relative 'actions/rail_car_actions'
require_relative 'menu'
require_relative 'helpers/ui_helpers'

def main
  stations_manager = StationsManager.new
  trains_manager = TrainsManager.new
  routes_manager = RoutesManager.new
  rail_car_manager = RailCarManager.new
  main_menu = Menu.new(
    {
      1 => 'Управление станциями',
      2 => 'Управление поездами',
      3 => 'Управление маршрутами',
      4 => 'Управление вагонами',
      5 => 'Просмотреть список станций и список поездов на станции',
      0 => 'Выход'

    }
  )
  loop do
    main_menu.display
    choice = main_menu.get_choice
    next if choice.nil?

    case choice

    when 1
      station_actions(stations_manager)
    when 2
      train_actions(trains_manager, rail_car_manager, routes_manager)
    when 3
      route_actions(routes_manager, stations_manager)
    when 4
      rail_car_actions(rail_car_manager)
    when 5
      # Реализация показа
    when 0
      break
    else
      puts UIHelpers.red('Something went wrong!')
    end
  end
end

main if __FILE__ == $0
