require_relative 'rail_car'
class CargoCar < RailCar
  attr_reader :total_volume, :occupied_volume

  def initialize(car_number, manufacturer, total_volume = 138)
    super(car_number, manufacturer)
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    raise 'Превышение доступного объема' if available_volume < volume || available_volume.zero?

    @occupied_volume += volume
  end

  def deoccupy_volume(volume)
    raise 'В вагоне нет такого объема' if (@occupied_volume - volume).negative?

    @occupied_volume -= volume
  end

  def available_volume
    @total_volume - @occupied_volume
  end
end
