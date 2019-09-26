def working_bets_string(wb)
  bets = ""
  wb.each { |bet|
    bets << Rainbow("$").green + Rainbow(bet.wager.to_s).green + " " + bet.type + "\n"
  }
  bets
end

def prepare_drill(max_bets, max_size)
  working_bets = []
  b_list = pick_bets(rand(1..max_bets))
  working_bets = place_bets(b_list, max_size)
  working_bets
end

def give_problem(working, winning_roll)
  print working_bets_string(working)
  puts winning_roll.result.to_s + " hits"
  puts
end

def get_answer(working, winning_roll)
  loop do
    print "What is the payout? "
    guess = gets.to_i
    if guess != wins_and_losses(working, winning_roll)
      puts Rainbow("Try again...").red
    else
      puts
      break
    end
  end
end

def drill(max_bets, max_size)
  working = prepare_drill(max_bets, max_size)
  winning_roll = roll_a_winner(working)
  give_problem(working, winning_roll)
  get_answer(working, winning_roll)
end
