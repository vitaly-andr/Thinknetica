require_relative '../entities/station'
require_relative '../helpers/ui_helpers'
class StationsManager
  def initialize
    @stations = []
  end

  def create(name)
    if @stations.any? { |station| station.name == name }
      puts UIHelpers.red("Станция с названием '#{name}' уже существует.")
    else
      new_station = Station.new(name)
      @stations << new_station
      puts UIHelpers.green("Станция '#{name}' успешно создана.")
      new_station
    end
  end

  def delete(name)
    station = @stations.find { |s| s.name == name }
    if station
      @stations.delete(station)
      puts UIHelpers.green("Станция '#{name}' была удалена.")
    else
      puts UIHelpers.red("Станция '#{name}' не найдена.")
    end
  end

  def rename(old_name, new_name)
    station = @stations.find { |s| s.name == old_name }
    if station
      station.name = new_name
      puts UIHelpers.green("Станция '#{old_name}' переименована в '#{new_name}'.")
    else
      puts UIHelpers.red("Станция '#{old_name}' не найдена.")
    end
  end

  def find_or_create(name)
    station = @stations.find { |s| s.name == name }
    if station
      station
    else
      puts UIHelpers.red("Станция '#{name}' не найдена.")
      user_choice = UIHelpers.get_user_input('Создать? Да/Нет')
      return create(name) if user_choice == 'Да'

      nil
    end
  end

  def list
    @stations.each { |station| puts UIHelpers.green(station.name) }
  end
end
