# frozen_string_literal: true

# Simple representation of a craps bet... the name of the bet, amount wagered,
# what outcomes the bet targets, and the payout depending on a roll of the dice
class Bet
  attr_reader :name, :wager

  def initialize(name, max_size)
    @name = name
    @wager = rand(1..max_size) # Change this to something normal
  end

  def outcomes
    bet.keys
  end

  def ways
    bet.length
  end

  def payout(roll)
    bet[roll] ? round(bet[roll] * @wager) : -@wager
  end

  def bet
    HOP_BETS[@name]
  end

  def round(result)
    result - result.to_i < 0.75 ? result.to_i : result.ceil
  end
end
