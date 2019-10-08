# Decided a class would be better
class BetList
  attr_reader :bets

  def initialize(num, max_size)
    @bets = []
    @max_size = max_size
    pick_bets(num)
  end

  def add_bet(name)
    @bets << Bet.new(name, @max_size)
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
