class Results
  def initialize
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
end
