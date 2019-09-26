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
