class Player
  attr_accessor :hand, :bank
  attr_reader :name

  def initialize(name, bank = 100)
    @name = name
    @bank = bank
    @hand = []
  end

  def take_card(card)
    @hand << card
  end

  def hand_value
    sum = 0
    aces = 0
    @hand.each do |card|
      sum += card.value
      aces += 1 if card.rank == 'A'
    end
    # Автоматическая корректировка значения туза, если сумма очков превышает 21
    aces.times { sum -= 10 if sum > 21 }
    sum
  end

  def display_hand(show_all: false)
    if show_all
      @hand.map(&:to_s).join(' ')
    else
      ' *' * @hand.size
    end
  end

  def bet(amount)
    raise 'Недостаточно средств для ставки' if amount > @bank

    @bank -= amount
  end
end
