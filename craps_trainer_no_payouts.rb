#!/usr/bin/env ruby

require 'yaml'
require_relative 'lib/roll'
require_relative 'lib/bet'

ROLL_NAMES = YAML.load(File.read("yaml/roll_names.yaml"))
BET_TYPES = YAML.load(File.read("yaml/bet_types.yaml"))

def pick_bets(num)
  BET_TYPES.keys.sample(num)
end

def place_bets(list, max_bet)
  wb = []
  list.each do |type|
    wb << Bet.new(type, rand(1..max_bet))
  end
  wb
end

def roll_a_winner(wb)
  valid = false
  dice = Roll.new
  
  while !valid do
    wb.each { |bet|
	  if bet.winners.include?(dice.name)
	    valid = true
		return dice.result
	  end
	}
	dice.reroll
  end
end

def working_bets_string(wb, wr)
  bets = ""
  wb.each { |bet|
    bets << "$" + bet.wager.to_s + " on " + bet.type + " * "
  }
  bets
end

def calculate_payout(winner, roll)
  puts "Calculating a " + winner.ways.to_s + " way bet"
  puts "The winner is " + (roll.uniq.length == 1 ? "hard" : "easy")
end

print "What is the maximum bet size? "
max_bet_size = gets.to_i

print "What is the maximum number of bets? "
max_unique_bets = gets.to_i

while 1 do
  working_bets = []
  b_list = pick_bets(rand(1..max_unique_bets))
  working_bets = place_bets(b_list, rand(1..max_bet_size))
  winning_roll = roll_a_winner(working_bets)

  calculate_payout(working_bets.first, winning_roll)

  print "Working bets: * " + working_bets_string(working_bets, winning_roll) + "\n"
  puts winning_roll.to_s + " HITS!"
  
  gets
end
