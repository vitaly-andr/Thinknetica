class CargoTrain < Train
  def add_car(car)
    unless car.is_a?(CargoCar)
      raise 'Недопустимый тип вагона. Только грузовые вагоны могут присоединяться к грузовому поезду.'
    end

    super(car)
  end
end
