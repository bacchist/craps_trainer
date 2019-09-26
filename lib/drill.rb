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
  puts working_bets_string(working)
  puts winning_roll.result.to_s + " hits"
  puts
end

def get_answer(working, winning_roll)
  prompt = TTY::Prompt.new

  prompt.on(:keypress) do |event|
    if event.value == "Q"
      display_results
    end
  end

  loop do
    guess = prompt.ask('What is the payout?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
    if guess != wins_and_losses(working, winning_roll)
      puts Rainbow("Try again...").red
    else
      puts
      break
    end
  end
end

def display_results
  abort "Goodbye"
end

def drill(max_bets, max_size, time_limit = false)
  prompt = TTY::Prompt.new
  prompt.on(:keypress) do |event|
    if event.value == "Q"
      display_results
    end
  end

  loop do
    working = prepare_drill(max_bets, max_size)
    winning_roll = roll_a_winner(working)
    give_problem(working, winning_roll)
    # if time_limit
    #   timer = Timer.new(time_limit) {
    #     puts "\r\nYou took too long\r\n"
    #     drill(max_bets, max_size, time_limit)
    #   }
    #   timer.start
    # end
    get_answer(working, winning_roll)
  end
end
