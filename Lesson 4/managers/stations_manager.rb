require_relative '../entities/station'
require_relative '../helpers/ui_helpers'
class StationsManager

  def create(name)
    if Station.find_by_name(name)
      puts UIHelpers.red("Станция с названием '#{name}' уже существует.")
    else
      Station.new(name)
      puts UIHelpers.green("Станция '#{name}' успешно создана.")
    end
  end

  def delete(name)
    if Station.find_by_name(name)
      Station.delete_by_name(name)
      puts UIHelpers.green("Станция '#{name}' была удалена.")
    else
      puts UIHelpers.red("Станция '#{name}' не найдена.")
    end
  end

  def rename(old_name, new_name)
    station = Station.find_by_name(old_name)
    if station
      station.name = new_name
      puts UIHelpers.green("Станция '#{old_name}' переименована в '#{new_name}'.")
    else
      puts UIHelpers.red("Станция '#{old_name}' не найдена.")
    end
  end

  def find_or_create(name)
    station = Station.find_by_name(name)
    return station if station

    puts UIHelpers.red("Станция '#{name}' не найдена.")
    user_choice = UIHelpers.get_user_input('Создать? Да/Нет').strip.downcase

    if user_choice == 'да'
      create(name) # вызываем метод create, который создаст и вернет новую станцию
      Station.find_by_name(name) # находим и возвращаем только что созданную станцию
    else
      nil
    end
  end

  def list
    puts UIHelpers.green( 'Зарегистрировано станций')
    puts Station.instances
    Station.all.each { |station| puts UIHelpers.green(station.name) }
  end
end
