class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def add_train(train)
    @trains[train.number] = train
  end

  def trains_list
    @trains.values
  end

  def train_types_count
    count = {
      cargo: 0,
      passenger: 0
    }
    @trains.each_value do |train|
      if train.train_type == 'cargo'
        count[:cargo] += 1
      elsif train.train_type == 'passenger'
        count[:passenger] += 1
      end
    end
    count
  end

  def remove_train(train)
    @trains.delete(train.number)
  end
end

class Route
  def initialize(station_start, station_end)
    @station_list = [station_start, station_end]
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

class Train
  ALLOWED_TYPES = %w[cargo passenger].freeze

  attr_reader :train_type

  def initialize(train_number, train_type, cars_count)
    @train_number = train_number
    @train_type = set_type(train_type)
    @train_speed = 0
    @cars_count = cars_count
  end

  def set_type(type)
    unless ALLOWED_TYPES.include?(type)
  raise "Invalid train type: #{type}. Allowed types are #{ALLOWED_TYPES.join(', ')}."
    end

    @train_type = type



  end

  def number
    @train_number
  end

  def train_speed(speed)
    @train_speed = speed
  end

  def get_train_speed
    @train_speed
  end

  def brake
    @train_speed = 0
  end

  def cars_count
    @cars_count
  end

  def add_car
    @cars_count += 1 if @train_speed.zero?
  end

  def remove_car
    @cars_count -= 1 if @train_speed.zero?
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
    # Raise an exception if trying to move forward from the last station
    unless @current_station_index < @route.stations_list.length - 1
      raise 'Cannot move forward: Train is at the last station.'
    end

    @current_station_index += 1

  end

  def move_backward
    # Raise an exception if trying to move backward from the first station
    raise 'Cannot move backward: Train is at the first station.' unless @current_station_index.positive?

    @current_station_index -= 1



  end

  def next_station
    @route.stations_list[@current_station_index + 1]
  end

  def previous_station
    @route.stations_list[@current_station_index - 1] if @current_station_index.positive?
  end

  def current_station
    @route.stations_list[@current_station_index]
  end
end

# Tests
# Testing the Station and Train classes
# Create stations
puts 'Creating a train station 1'
station1 = Station.new('Station 1')
puts 'Creating a train station 1'
station2 = Station.new('Station 2')

# Create trains
puts 'Creating a train  1'
train1 = Train.new('001', 'cargo', 10)
puts 'Creating a train  2'
train2 = Train.new('002', 'passenger', 15)

puts 'Adding a train 1 to station 1'
station1.add_train(train1)
puts 'Adding a train 2 to station 1'
station1.add_train(train2)
puts 'Expect: List containing train1 and train2 objects'
puts station1.trains_list # Expect: List containing train1 and train2 objects
puts 'Expect: { cargo: 1, passenger: 1 }'
puts station1.train_types_count # Expect: { cargo: 1, passenger: 1 }
puts 'Removing a train 1 from station 1'
station1.remove_train(train1)
puts station1.trains_list # Expect: List containing only train2

# Testing the Route Class
puts 'Creating a route'
route = Route.new(station1, station2)
puts 'Creating intermediate station'
intermediate_station = Station.new('Intermediate Station')
puts 'Adding intermediate station to the route'
route.add_station(intermediate_station, 1)
puts 'Expect: [station1, intermediate_station, station2]'
route.stations_list.each do |station|
  puts station.name
end
puts 'Removing intermediate station'
route.remove_station(intermediate_station)
puts route.stations_list  # Expect: [station1, station2]

# Testing Train Movement on the Route
puts 'Accepting route by train 2'
train2.accept_route(route)
puts 'Expect: "Station 1"'
puts train2.current_station.name # Expect: "Station 1"

# Move the train forward
puts 'Moving forward'
train2.move_forward
puts train2.current_station.name # Expect: "Station 2"
puts 'Moving forward beyond the last station'
begin
  train2.move_forward  # Attempts to move the train forward
rescue RuntimeError => e
  puts e.message  # Prints the error message from the exception
end
# Check next and previous stations
puts 'next station Expect: nil (since it is  at the end)'
puts train2.next_station # Expect: nil (since it's at the end)
puts 'previous station Expect: "Station 1"'
puts train2.previous_station.name # Expect: "Station 1"

# Move the train backward
puts 'Moving backward'
train2.move_backward
puts 'Expect: "Station 1"'
puts train2.current_station.name # Expect: "Station 1"

# Test speed management
train2.train_speed(40)
puts "Speed of Train 2: #{train2.get_train_speed} Expect: 40" # Expect: 40
train2.brake
puts "Speed of Train 2 after braking: #{train2.get_train_speed} Expect: 0" # Expect: 0

# Test car management
puts "Initial cars in Train 2: #{train2.cars_count} Expect: 15" # Expect: 15
train2.add_car
puts "Cars in Train 2 after adding one: #{train2.cars_count} Expect: 16" # Expect: 16
train2.remove_car
puts "Cars in Train 2 after removing one: #{train2.cars_count} Expect: 15" # Expect: 15
