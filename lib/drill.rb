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

def get_answer(working, winning_roll, results)
  prompt = TTY::Prompt.new

  prompt.on(:keypress) do |event|
    if event.value == "Q"
      display_results(results)
    end
  end

  loop do
    guess = prompt.ask('What is the payout?') do |q|
      q.convert :int
    end
    if guess != wins_and_losses(working, winning_roll)
      puts Rainbow("Try again...").red
      results[:asked] += 1
    else
      results[:correct] += 1
      puts
      break
    end
  end
end

def display_results(results)
  $timer.defuse if $timer
  $stdout.cooked!
  good = results[:correct]
  total = results[:asked]
  time = results[:drill_time]
  maxb = results[:bets]
  maxs = results[:size]
  score = good.to_f / total
  puts "You answered #{good} correct out of #{total}."
  puts "That's #{score*100}%"
  File.open("results.txt", "a") do |f|
    f.puts "(#{Time.now.strftime('%m/%d/%Y %I:%M %p')}) [size: #{maxs} bets: #{maxb} time: #{time}s]  #{good} of #{total} <%#{(score*100).round(2)}>"
  end
  abort "Thanks for playing!"
end

def drill(max_bets, max_size, drill_time = false)
  results = { asked: 0, correct: 0, bets: max_bets, size: max_size }

  if drill_time
    results[:drill_time] = drill_time
    timer = Timer.new(drill_time) { display_results(results) }
    timer.start
  end

  loop do
    working = prepare_drill(max_bets, max_size)
    winning_roll = roll_a_winner(working)
    give_problem(working, winning_roll)
    results[:asked] += 1
    get_answer(working, winning_roll, results)
  end
end
