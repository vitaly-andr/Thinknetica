# frozen_string_literal: true

require_relative '../helpers/ui_helpers'
require_relative '../menu'
require_relative '../managers/stations_manager'

def create_station(stations_manager)
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  name = UIHelpers.get_user_input('Введите название новой станции:')
  begin
    result = stations_manager.create(name)
    puts UIHelpers.green(result)
  rescue StandardError => e
    puts UIHelpers.red(e.message)
  end
end

def delete_station(stations_manager)
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  name = UIHelpers.get_user_input('Введите название станции для удаления:')
  begin
    result = stations_manager.delete(name)
    puts UIHelpers.green(result)
  rescue StandardError => e
    puts UIHelpers.red(e.message)
  end
end

def rename_station(stations_manager)
  puts UIHelpers.green('Список всех станций:')
  stations_manager.list
  name = UIHelpers.get_user_input('Введите название станции для переименования:')
  new_name = UIHelpers.get_user_input('Введите новое название станции:')

  begin
    result = stations_manager.rename(name, new_name)
    puts UIHelpers.green(result)
  rescue StandardError => e
    puts UIHelpers.red(e.message)
  end
end

# Создаем меню для управления станциями как константу
STATION_MENU = Menu.new(
  {
    1 => 'Создать станцию',
    2 => 'Удалить станцию',
    3 => 'Переименовать станцию',
    4 => 'Вывести список всех станций',
    0 => 'Вернуться в главное меню'
  }
).freeze

def initialize_station_actions(stations_manager)
  {
    1 => -> { create_station(stations_manager) },
    2 => -> { delete_station(stations_manager) },
    3 => -> { rename_station(stations_manager) },
    4 => lambda {
      puts UIHelpers.green('Список всех станций:')
      stations_manager.list
    },
    0 => -> { false }
  }.freeze
end

def process_station_menu_choice(choice, station_actions)
  action = station_actions[choice]
  if action
    action.call
  else
    puts UIHelpers.red('Something went wrong!')
  end
  true
end

def station_actions(stations_manager)
  station_actions = initialize_station_actions(stations_manager)
  loop do
    STATION_MENU.display
    choice = STATION_MENU.get_choice
    next if choice.nil?

    break unless process_station_menu_choice(choice, station_actions)
  end
end
