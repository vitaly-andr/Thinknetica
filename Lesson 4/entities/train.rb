class Train
  attr_accessor :speed, :route
  attr_reader :number, :cars, :current_station_index
  # Так как напрямую объекты Train не создаются никогда я сделал инициализацию private (подклассы его видят)

  private

  def initialize(train_number)
    @number = train_number
    @speed = 0
    @cars = []
    @route = nil
  end

  public

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
  # Мне кажется логично хранить отцепленные вагоны на соответствующих станциях, но на этом этапе в задании этого нет

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
