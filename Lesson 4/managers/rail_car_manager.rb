require_relative '../entities/rail_car'
require_relative '../entities/passenger_car'
require_relative '../entities/cargo_car'
class RailCarManager
  ALLOWED_CAR_TYPES = %i[cargo passenger].freeze

  def initialize
    @cars = []
  end

  def create(car_type, car_number)
    type_sym = car_type.to_sym.downcase

    # Проверка на уникальность номера вагона
    if @cars.any? { |car| car.car_number == car_number }
      puts UIHelpers.red("Вагон с номером '#{car_number}' уже существует.")
      return
    end

    # Проверка допустимости типа вагона
    unless ALLOWED_CAR_TYPES.include?(type_sym)
      puts UIHelpers.red("Недопустимый тип вагона: #{car_type}. Возможные типы: #{ALLOWED_CAR_TYPES.join(', ')}.")
      return
    end

    # Создание вагона в зависимости от типа
    new_car = case type_sym
              when :passenger
                PassengerCar.new(car_number)
              when :cargo
                CargoCar.new(car_number)
              else
                puts UIHelpers.red("Ошибка логики: недопустимый тип вагона '#{car_type}'.")
                return
              end

    # Добавление вагона в список
    @cars << new_car
    puts UIHelpers.green("Вагон '#{car_number}' типа '#{car_type}' успешно создан.")
    new_car
  end

  def delete(car_number)
    car = @cars.find { |s| s.car_number == car_number }
    if car
      @cars.delete(car)
      puts UIHelpers.green("Вагон номер '#{car_number}' успешно удален.")
    else
      puts UIHelpers.red("Вагон номер '#{car_number}' не найден.")
    end
  end

  # Prints list and returns unattached cars
  def list_cars(free_filter: false)
    if free_filter
      @cars.select { |car| car.attached_to.nil? }
    else
      @cars.each do |car|
        attached_info = car.attached_to ? UIHelpers.green(car.attached_to.to_s) : UIHelpers.green('Свободен')
        puts UIHelpers.green("#{car.car_number} - #{car.class} прицеплен к #{attached_info}")
      end
    end
  end
end
