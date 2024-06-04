require_relative '../helpers/ui_helpers'
require_relative '../menu'
require_relative '../managers/stations_manager'
def station_actions(stations_manager)
  station_menu = Menu.new(
    {
      1 => 'Создать станцию',
      2 => 'Удалить станцию',
      3 => 'Переименовать станцию',
      4 => 'Вывести список всех станций',
      0 => 'Вернуться в главное меню'
    }
  )
  loop do
    station_menu.display
    choice = station_menu.get_choice
    next if choice.nil?

    case choice
    when 1
      puts UIHelpers.green('Список всех станций:')
      stations_manager.list
      name = UIHelpers.get_user_input('Введите название новой станции:')
      stations_manager.create(name)
    when 2
      puts UIHelpers.green('Список всех станций:')
      stations_manager.list
      name = UIHelpers.get_user_input('Введите название станции для удаления:')
      stations_manager.delete(name)
    when 3
      puts UIHelpers.green('Список всех станций:')
      stations_manager.list
      name = UIHelpers.get_user_input('Введите название станции для переименования:')
      new_name = UIHelpers.get_user_input('Введите новое название станции:')
      stations_manager.rename(name, new_name)
    when 4
      puts UIHelpers.green('Список всех станций:')
      stations_manager.list
    when 0
      break
    else
      puts UIHelpers.red('Something went wrong.')
    end
  end
end
