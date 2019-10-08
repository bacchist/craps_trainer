class Drill
  attr_reader :bet_list

  def initialize(max_bets, max_size)
    @results = { asked: 0, correct: 0, bets: max_bets, size: max_size }
    @max_bets = max_bets
    @max_size = max_size
    @dice = Roll.new
  end

  def new_problem
    @bet_list = BetList.new(@max_bets, @max_size)
  end

  def display
    @bet_list.display
    @dice.roll until @bet_list.outcomes.include? @dice.name
    puts " ==> #{@dice} hits"
  end

  def evaluate(answer)
    answer == correct
  end

  def correct
    @bet_list.payouts(@dice.name)
  end
end
