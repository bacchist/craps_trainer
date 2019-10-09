# frozen_string_literal: true

# Requests a list of bets according to user options, rolls the dice to
# find a winner, checks the user's response against the expected answer.
class Drill
  attr_reader :bet_list

  def initialize(options)
    @options = defaults.merge(options)
    @dice = Roll.new
  end

  def new_problem
    #binding.pry
    @options[:num] = rand(1..@options[:max_bets])
    @bet_list = BetList.new(@options)
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

  private

  def defaults
    { max_bets: 2, max_size: 10, irregular: false }
  end
end
