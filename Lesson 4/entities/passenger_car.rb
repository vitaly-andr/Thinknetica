require_relative 'rail_car'
class PassengerCar < RailCar
  attr_reader :total_seats, :occupied_seats

  def initialize(car_number, manufacturer, total_seats = 50)
    super(car_number, manufacturer)
    @total_seats = total_seats
    @occupied_seats = 0
  end

  def occupy_seat
    raise 'В вагоне нет такого количества свободных мест' if @occupied_seats >= @total_seats

    @occupied_seats += 1
  end

  def deoccupy_seat
    raise 'В вагоне нет такого количества занятых мест' if @occupied_seats <= 0

    @occupied_seats -= 1
  end

  def rollback_occupied_seats(initial_occupied_seats)
    @occupied_seats = initial_occupied_seats
  end

  def available_seats
    @total_seats - @occupied_seats
  end
end
