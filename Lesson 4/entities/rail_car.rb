require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'

class RailCar
  include Manufacturer
  include InstanceCounter
  attr_accessor :attached_to
  attr_reader :car_number

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
    self.class.add_car(self)
    register_instance

  end
end
