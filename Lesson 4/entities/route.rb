require_relative '../modules/instance_counter'

class Route
  include InstanceCounter

  class << self
    def all
      @all ||= []
    end

    def add_route(route)
      all << route
    end

    def find_by_index(index)
      all[index]
    end

    def delete_by_index(index)
      route = find_by_index(index)
      return unless route

      all.delete(route)
      route.send(:deregister_instance)
    end
  end
  def initialize(station_start, station_end)
    @station_list = [station_start, station_end]
    self.class.add_route(self)
    register_instance
  end

  def add_station(station, index = 1)
    @station_list.insert(index, station)
  end

  def remove_station(station)
    @station_list.delete(station)
  end

  def stations_list
    @station_list
  end
end
