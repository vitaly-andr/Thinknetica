require_relative '../entities/rail_car'
require_relative '../entities/passenger_car'
require_relative '../entities/cargo_car'
require_relative '../helpers/ui_helpers'

class RailCarManager
  ALLOWED_TYPES = %i[cargo passenger].freeze

  def create(car_type, car_number, manufacturer)
    type = car_type.strip.downcase.to_sym # Преобразуем введенную строку в символ
    unless ALLOWED_TYPES.include?(type)
      puts UIHelpers.red("Неверный тип вагона. Допустимые типы: #{ALLOWED_TYPES.join(', ')}.")
      return
    end
    # Проверка на уникальность номера вагона
    car = find(car_number)
    if car
      puts UIHelpers.red("Вагон с номером '#{car_number}' уже существует.")
    else
      type == :passenger ? PassengerCar.new(car_number, manufacturer) : CargoCar.new(car_number, manufacturer)

      puts UIHelpers.green("Вагон '#{car_number}' успешно создан.")
    end

  end

  def delete(car_number)
    car = find(car_number)
    if car
      car.class.delete(car)
      puts UIHelpers.green("Вагон номер '#{car_number}' успешно удален.")
    else
      puts UIHelpers.red("Вагон номер '#{car_number}' не найден.")
    end
  end

  # Prints list and returns unattached cars
  def list_cars(free_filter: false)
    puts 'Зарегистрировано пассажирских вагонов'
    puts PassengerCar.instances
    puts 'Зарегистрировано грузовых вагонов'
    puts CargoCar.instances
    all_cars = PassengerCar.all + CargoCar.all
    if free_filter
      all_cars.select { |car| car.attached_to.nil? }
    else
      all_cars.each do |car|
        attached_info = car.attached_to ? UIHelpers.green(car.attached_to.number) : UIHelpers.green('Свободен')
        puts UIHelpers.green("#{car.car_number} Производитель - #{car.name} - #{car.class} прицеплен к поезду № #{attached_info}")
      end
    end
  end

  def find(car_number)
    car = PassengerCar.find(car_number)
    car || CargoCar.find(car_number)
  end
end
