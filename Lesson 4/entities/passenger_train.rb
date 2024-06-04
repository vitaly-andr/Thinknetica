class PassengerTrain < Train
  def add_car(car)
    unless car.is_a?(PassengerCar)
      raise 'Недопустимый тип вагона. Только пассажирские вагоны могут присоединяться к пассажирскому поезду.'
    end

    super(car)
  end
end

