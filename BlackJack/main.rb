require_relative 'game'
def main
  puts 'Добро пожаловать в игру Блэкджек!'
  print 'Введите ваше имя: '
  name = gets.chomp
  game = Game.new(name)
  game.start_game
end

main if __FILE__ == $PROGRAM_NAME
