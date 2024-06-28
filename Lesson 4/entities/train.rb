require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'
require_relative '../modules/accessors'
require_relative '../modules/validation'
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  include Accessors

  TRAIN_NUMBER_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/.freeze
  TRAIN_NUMBER_MESSAGE = 'номер поезда должен состоять из 3 букв или цифр, затем опционального дефиса и затем 2 букв или цифр.'.freeze


  attr_accessor_with_history :speed, :route
  attr_reader :number, :cars, :current_station_index

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT, TRAIN_NUMBER_MESSAGE
  validate :number, :type, String
  class << self
    def all
      @all ||= []
    end

    def find(train_number)
      all.find { |t| t.number == train_number }
    end

    def add_train(train)
      all << train
    end

    def delete(train)
      all.delete(train)
      train.send(:deregister_instance)
    end
  end

  private

  def initialize(train_number, manufacturer_name)
    @number = train_number
    @name = manufacturer_name
    @speed = 0
    @cars = []
    @route = nil
    validate!
    self.class.add_train(self)
    register_instance
  end

  def validate!
    raise 'Номер поезда не может быть пустым' if @number.nil? || @number.empty?
    return if @number =~ /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/

    raise 'номер поезда должен состоять из 3 букв или цифр, затем опционального дефиса и затем 2 букв или цифр.'
  end

  public

  def valid?
    validate!
    true
  rescue StandardError => e
    @last_error = e.message
    false
  end

  def add_car(car)
    raise 'Нельзя прицепить вагон, пока поезд движется.' unless @speed.zero?
    raise 'Этот вагон уже прицеплен к поезду' if car.attached_to

    car.attached_to = self
    @cars << car
  end

  def remove_car(car)
    raise 'Нельзя отцепить вагон, пока поезд движется.' unless @speed.zero?
    raise 'Такого вагона нет в этом поезде'  unless @cars.include?(car)

    car.attached_to = nil
    @cars.delete(car)
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
    raise 'Нет прикрепленного маршрута' unless @route.is_a?(Route)
    # Raise an exception if trying to move forward from the last station
    unless @current_station_index < @route.stations_list.length - 1
      raise 'Cannot move forward: Train is at the last station.'
    end

    @current_station_index += 1
  end

  def move_backward
    raise 'Нет прикрепленного маршрута' unless @route.is_a?(Route)
    # Raise an exception if trying to move backward from the first station
    raise 'Cannot move backward: Train is at the first station.' unless @current_station_index.positive?

    @current_station_index -= 1
  end
end
