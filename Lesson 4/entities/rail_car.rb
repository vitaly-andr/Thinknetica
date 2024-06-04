class RailCar
  attr_accessor :attached_to
  attr_reader :car_number
  # Так как напрямую объекты Train не создаются никогда я сделал инициализацию private (подклассы его видят)

  private

  def initialize(car_number)
    @car_number = car_number
    @attached_to = nil
  end
end
