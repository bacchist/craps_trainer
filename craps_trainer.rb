#!/usr/bin/env ruby

require 'yaml'
require 'rainbow'
require 'byebug'
require_relative 'lib/roll'
require_relative 'lib/bet'

# Load some static values from YAML files

ROLL_NAMES = YAML.load(File.read("yaml/roll_names.yaml"))    # Pointers for identifying dice pairs
BET_TYPES = YAML.load(File.read("yaml/bet_types.yaml"))      # The names of bets and their win conditions
ALT_PAYOUTS = YAML.load(File.read("yaml/exceptions.yaml"))   # Which bets use alternate payout calculation

def pick_bets(num)                # Select the desired number of bets without duplication
  BET_TYPES.keys.sample(num)
end

def place_bets(list, max_bet)     # Return an array of specified Bet objects with random wagers
  wb = []
  list.each do |type|
    wb << Bet.new(type, rand(1..max_bet))
  end
  wb
end

def roll_a_winner(wb)             # Roll some dice. Keep rerolling until a
  valid = false                   # working bet's win condition is met.
  dice = Roll.new                 # Returns a Roll object (pair of dice).

  while !valid do
    wb.each { |bet|
	  if bet.winners.include?(dice.name)
	    valid = true
      return dice
	  end
	}
	dice.reroll
  end
end

def working_bets_string(wb)       # Returns a suitable string of working bets
  bets = ""
  wb.each { |bet|
    bets << Rainbow("$").green + Rainbow(bet.wager.to_s).green + " " + bet.type + "\n"
  }
  bets
end

def round(chips)                  # Rounds like a casino.
  if chips - chips.to_i < 0.75
    chips.to_i
  else
    chips = chips.ceil
  end
end

def calculate_payout(winner, roll)
  if winner.exceptional?
    case winner.exception
      when "Crap Check"
        if winner.type == "C & E" && roll.name == :yo
          return winner.wager * 6.5
        elsif winner.type == "C & E"
          return winner.wager * 1.5
        elsif roll.name == :aces || roll.name == :ace_deuce || roll.name == :twelve
          return winner.wager * 4
        end
      when "Red"
        if winner.type == "Seven/Eleven" && roll.name == :seven
          return winner.wager * 1.5
        elsif winner.type == "Seven/Eleven"
          return winner.wager * 6.5
        else
          return winner.wager * 4
        end
      when "Horn High"
        if winner.type == "Horn High Aces" && roll.name == :aces
          return round(30 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Ace-Deuce" && roll.name == :ace_deuce
          return round(15 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Yo" && roll.name == :yo
          return round(15 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Twelve" && roll.name == :twelve
          return round(30 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        end
    end
  end
  if winner.type == "World Bet" && roll.name == :seven
    return 0
  end
  h = roll.is_hard? ? 30 : 15
  w = winner.wager.to_f / winner.ways
  round(h * w - winner.wager)
end


def wins_and_losses(working, roll)          # Subtracts losing wagers from payouts
  winnings = 0
  working.each { |wb|
    if wb.winners.include?(roll.name)
	    winnings = winnings + calculate_payout(wb, roll)
    else
	    winnings = winnings - wb.wager
    end
  }
  winnings
end

print "What is the maximum bet size? "
max_bet_size = gets.to_i

print "What is the maximum number of bets? "
max_unique_bets = gets.to_i

while 1 do
  working_bets = []
  b_list = pick_bets(rand(1..max_unique_bets))
  working_bets = place_bets(b_list, max_bet_size)
  winning_roll = roll_a_winner(working_bets)

  print working_bets_string(working_bets)
  puts winning_roll.result.to_s + " HITS!"
  puts

  while 1 do
    print "What is the payout? "
    guess = gets.to_i
    if guess != wins_and_losses(working_bets, winning_roll)
      puts Rainbow("Try again...").red
    else
      puts
      break
    end
  end
end
