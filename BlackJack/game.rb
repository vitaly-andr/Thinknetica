require_relative 'deck'
require_relative 'player'
class Game
  attr_accessor :deck, :player, :dealer, :pot

  def initialize(player_name)
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Player.new('Dealer')
    @pot = 0
  end

  def start_game
    puts 'Игра началась.'
    puts "У #{@player.name} - #{@player.bank}"
    puts "У дилера - #{@dealer.bank}"
    2.times { @player.take_card(@deck.deal_card) }
    2.times { @dealer.take_card(@deck.deal_card) }
    place_initial_bets
    show_hands
    player_turn
  end

  def place_initial_bets

    @player.bet(10)
    @dealer.bet(10)
    @pot += 20
    puts "Ставка сделана. В банке: #{@pot} долларов."
  rescue RuntimeError => e
    puts e.message
    ask_to_play_again

  end

  def show_hands
    puts "Ваши карты: #{player.display_hand(show_all: true)}"
    puts "Карты дилера: #{dealer.display_hand}"
  end

  def player_turn
    loop do
      puts "Ваши очки: #{player.hand_value}"
      puts 'Выберите действие: (1) Пропустить (2) Взять карту (3) Открыть карты'
      case gets.chomp
      when '1'
        dealer_turn
        break
      when '2'
        @player.take_card(@deck.deal_card)
        show_hands
        if @player.hand.size >= 3
          dealer_turn
          break
        end
      when '3'
        dealer_play_final_cards
        reveal_cards
        break
      else
        puts 'Неверный ввод. Пожалуйста, выберите 1, 2 или 3.'
      end
    end
  end

  def dealer_turn
    if @dealer.hand_value < 17 && @dealer.hand.size < 3
      @dealer.take_card(@deck.deal_card)
      puts 'Дилер берет карту.'
    end
    if @player.hand.size == 3
      reveal_cards
    else
      player_turn
    end
  end

  def dealer_play_final_cards
    while @dealer.hand_value < 17 && @dealer.hand.size < 3
      @dealer.take_card(@deck.deal_card)
      puts 'Дилер берет карту.'
    end
    reveal_cards
  end
  def reveal_cards
    puts "Карты дилера: #{dealer.display_hand(show_all: true)}"
    puts "Очки дилера: #{dealer.hand_value}"
    compare_scores
  end

  def compare_scores
    player_score = @player.hand_value
    dealer_score = @dealer.hand_value

    if player_score > 21
      puts "Перебор! Вы проиграли. Ваш счет: #{player_score}"
      @dealer.bank += @pot
    elsif dealer_score > 21 || player_score > dealer_score
      puts "Вы выиграли! Ваш счет: #{player_score}, счет дилера: #{dealer_score}"
      @player.bank += @pot
    elsif dealer_score == player_score
      puts "Ничья. Ваш счет: #{player_score}, счет дилера: #{dealer_score}"
      @player.bank += @pot / 2
      @dealer.bank += @pot / 2
    else
      puts "Дилер выиграл. Счет дилера: #{dealer_score}"
      @dealer.bank += @pot
    end
    @pot = 0
    ask_to_play_again
  end

  def end_game
    puts "Игра окончена. У вас осталось: #{@player.bank} долларов."
    exit
  end

  def ask_to_play_again
    puts 'Хотите сыграть еще раз? (да/нет)'
    response = gets.chomp.downcase
    if response == 'да'
      @pot = 0
      @player.hand = []
      @dealer.hand = []
      start_game
    else
      end_game
    end
  end
end
