class Card
  attr_reader :rank, :suit

  SUITS = %w[♣ ♦ ♥ ♠].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank}#{@suit}"
  end

  def value
    return 10 if %w[J Q K].include?(@rank)
    return 11 if @rank == 'A'

    @rank.to_i
  end
end