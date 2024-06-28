# frozen_string_literal: true

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
require_relative 'actions/seed_action'

# Инициализируем менеджеров
stations_manager = StationsManager.new
trains_manager = TrainsManager.new
routes_manager = RoutesManager.new
rail_car_manager = RailCarManager.new
seed_action = SeedAction.new

# Создаем хэш действий как константу
ACTIONS = {
  1 => -> { station_actions(stations_manager) },
  2 => -> { train_actions(trains_manager, rail_car_manager, routes_manager) },
  3 => -> { route_actions(routes_manager, stations_manager) },
  4 => -> { rail_car_actions(rail_car_manager) },
  5 => -> { stations_manager.list_stations_and_trains },
  100 => -> { seed_action.seed(trains_manager, rail_car_manager, routes_manager, stations_manager) },
  0 => -> { false }
}.freeze

# Создаем меню как константу
MAIN_MENU = Menu.new(
  {
    1 => 'Управление станциями',
    2 => 'Управление поездами',
    3 => 'Управление маршрутами',
    4 => 'Управление вагонами',
    5 => 'Просмотреть список станций и список поездов на станции',
    100 => 'Засеять демо данными',
    0 => 'Выход'
  }
).freeze

def process_menu_choice(choice)
  action = ACTIONS[choice]
  if action
    result = action.call
    return true if result.nil?

    result
  else
    puts UIHelpers.red('Something went wrong!')
  end
end

def main_loop
  loop do
    MAIN_MENU.display
    choice = MAIN_MENU.get_choice
    next if choice.nil?

    puts "Choice: #{choice}"
    break unless process_menu_choice(choice)
  end
end

def main
  main_loop
end

main if __FILE__ == $PROGRAM_NAME
