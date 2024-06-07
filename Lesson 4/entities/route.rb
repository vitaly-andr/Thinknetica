require_relative '../modules/instance_counter'

class Route
  include InstanceCounter
  def initialize(station_start, station_end)
    @station_list = [station_start, station_end]
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
