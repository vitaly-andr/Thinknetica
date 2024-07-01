require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each { |rank| @cards << Card.new(rank, suit) }
    end
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end