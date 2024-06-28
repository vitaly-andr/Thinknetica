require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'
require_relative '../modules/accessors'
require_relative '../modules/validation'

class RailCar
  include Manufacturer
  include InstanceCounter
  include Validation
  include Accessors

  CAR_NUMBER_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/.freeze
  CAR_NUMBER_MESSAGE = 'номер вагона должен состоять из 3 букв или цифр, затем опционального дефиса и затем 2 букв или цифр.'.freeze

  attr_accessor_with_history :attached_to
  strong_attr_accessor :car_number, String

  validate :car_number, :presence
  validate :car_number, :format, CAR_NUMBER_FORMAT, CAR_NUMBER_MESSAGE
  validate :car_number, :type, String
  class << self
    def all
      @all ||= []
    end

    def add_car(car)
      all << car
    end

    def find(car_number)
      all.find { |car| car.car_number == car_number }
    end

    def delete(car)
      all.delete(car)
      car.send(:deregister_instance)
    end
  end

  private

  def initialize(car_number, manufacturer)
    @car_number = car_number
    @attached_to = nil
    @name = manufacturer
    puts 'Массив валидаций для вагона'
    puts self.class.validations.inspect
    validate!
    self.class.add_car(self)
    register_instance
  end

end
