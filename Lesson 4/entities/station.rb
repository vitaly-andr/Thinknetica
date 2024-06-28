require_relative '../modules/instance_counter'
require_relative '../modules/validation'
require_relative '../modules/accessors'
class Station
  include InstanceCounter
  include Validation
  include Accessors

  validate :name, :presence
  validate :name, :type, String

  attr_accessor_with_history :name, :trains

  class << self
    def all
      @all ||= []
    end

    def find_by_name(name)
      all.find { |station| station.name == name }
    end

    def add_station(station)
      all << station
    end

    def delete_by_name(name)
      station = find_by_name(name)
      return unless station

      all.delete(station)
      station.send(:deregister_instance)
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.add_station(self)
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  # Метод для перебора всех поездов на станции с применением блока
  def each_train(&block)
    @trains.each(&block)
  end
end
