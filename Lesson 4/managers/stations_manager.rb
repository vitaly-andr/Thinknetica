require_relative '../entities/station'
require_relative '../helpers/ui_helpers'
class StationsManager

  def create(name)
    raise "Станция с названием '#{name}' уже существует." if Station.find_by_name(name)

    Station.new(name)
    puts UIHelpers.green("Станция '#{name}' успешно создана.")

  end

  def delete(name)
    raise "Станция '#{name}' не найдена." unless Station.find_by_name(name)

    Station.delete_by_name(name)
    "Станция '#{name}' была удалена."

  end

  def rename(old_name, new_name)
    station = Station.find_by_name(old_name)
    raise "Станция '#{old_name}' не найдена." unless station

    station.name = new_name
    "Станция '#{old_name}' переименована в '#{new_name}'."

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
