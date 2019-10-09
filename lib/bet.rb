# frozen_string_literal: true

# Simple representation of a craps bet... the name of the bet, amount wagered,
# what outcomes the bet targets, and the payout depending on a roll of the dice
class Bet
  attr_reader :name, :wager

  def initialize(name, max_size, irregular)
    @name = name
    @wager = rand(ways..max_size)
    normalize_wager unless irregular
  end

  def outcomes
    bet.keys
  end

  # This is probably not the best way to do this...
  def ways
    ROLL_NAMES.select { |k, _v| outcomes.include? k }.values.flatten.length / 2
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

  def normalize_wager
    @wager += 1 until (@wager % ways).zero? || (@wager % 5).zero?
  end
end
