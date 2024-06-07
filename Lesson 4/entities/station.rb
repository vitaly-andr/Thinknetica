require_relative '../modules/instance_counter'
class Station
  attr_accessor :name

  @stations = []

  class << self
    attr_accessor :stations

    def all
      @stations
    end

    def add_station(station)
      @stations << station
    end
  end

  def initialize(name)
    @name = name
    self.class.add_station(self)
    register_instance
  end
end

