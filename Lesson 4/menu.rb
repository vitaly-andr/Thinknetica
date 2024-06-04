class Menu
  attr_reader :prompt, :range, :options

  def initialize(options, prompt = 'Выберите пункт меню:')
    keys = options.keys.minmax
    @range = (keys[0]..keys[1])
    @options = options
    @prompt = prompt
  end

  def display
    options.each { |key, value| puts "#{key}. #{value}" }
    print "#{prompt} "
  end

  def get_choice
    loop do
      choice = gets.chomp
      return choice.to_i if valid_input?(choice)

      puts 'Неверный ввод. Пожалуйста, выберите номер из списка.'
    end
  end

  private

  def valid_input?(input)
    input.match?(/^\d+$/) && range.cover?(input.to_i)
  end
end
