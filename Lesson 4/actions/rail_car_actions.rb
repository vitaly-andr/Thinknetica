require_relative '../helpers/ui_helpers'
require_relative '../menu'
require_relative '../managers/rail_car_manager'

def rail_car_actions(rail_car_manager)
  car_menu = Menu.new(
    {
      1 => 'Создать вагон',
      2 => 'Удалить вагон',
      3 => 'Просмотреть список всех вагонов',
      0 => 'Вернуться в главное меню'
    }
  )

  loop do
    car_menu.display
    choice = car_menu.get_choice
    next if choice.nil?

    case choice
    when 1
      puts UIHelpers.green('Список всех вагонов:')
      rail_car_manager.list_cars
      car_type = UIHelpers.get_user_input('Введите тип вагона (passenger/cargo):')
      car_number = UIHelpers.get_user_input('Введите номер вагона:')
      rail_car_manager.create(car_type, car_number)
    when 2
      puts UIHelpers.green('Список всех вагонов:')
      rail_car_manager.list_cars
      car_number = UIHelpers.get_user_input('Введите номер вагона для удаления:')
      rail_car_manager.delete(car_number)
    when 3
      puts UIHelpers.green('Список всех вагонов:')
      rail_car_manager.list_cars
    when 0
      break
    else
      puts UIHelpers.red('Something went wrong.')
    end
  end
end
