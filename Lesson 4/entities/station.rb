require_relative '../modules/instance_counter'
class Station
  include InstanceCounter
  attr_accessor :name


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
    validate!
    self.class.add_station(self)
    register_instance
  end

  private
  def validate!
    raise 'Имя станции не может быть пустым' if @name.nil? || @name.empty?
  end
end

