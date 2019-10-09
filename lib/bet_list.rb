# frozen_string_literal: true

# Assembles a list of Bets, provides a list of winning outcomes,
# tallies up the payouts.
class BetList
  attr_reader :bets

  def initialize(options)
    @bets = []
    @max_size = options[:max_size]
    @irregular = options[:irregular]
    pick_bets(options[:num])
  end

  def add_bet(name)
    @bets << Bet.new(name, @max_size, @irregular)
  end

  def display
    @bets.each { |bet| print "| $#{bet.wager} #{bet.name} |" }
  end

  # Select the desired number of bets without duplication
  def pick_bets(num)
    HOP_BETS.keys.sample(num).each { |name| add_bet(name) }
  end

  def payouts(roll)
    @bets.map { |b| b.payout(roll) }.sum
  end

  def outcomes
    @bets.map(&:outcomes).flatten.uniq
  end
end
