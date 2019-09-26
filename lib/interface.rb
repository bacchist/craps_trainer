def load_game
  prompt = TTY::Prompt.new

  choices = [
    { key: 'e', name: "Use [e]xisting profile", value: :existing,
      disabled: "none present" },
    { key: 'n', name: "Create [n]ew profile", value: :new },
    { key: 'p', name: "Drill in [p]ractice mode", value: :practice }
  ]

  selection = prompt.expand('Profile options:', choices)

  case selection
  when :existing
    profile = prompt.select('Select a profile:', available_profiles)
  when :new
    new_profile = prompt.collect do
      key(:name).ask('Profile Name:')
      key(:defaults) do
        key(:max_bets).ask('Max bet size:')
        key(:max_uniq).ask('Max # of bets:')
        key(:time_limit).ask('Time limit:')
        key(:timed).ask('Timed challenge:')
        key(:drill_len).ask('Drill length:')
      end
    end
    File.open("yaml/profiles.yml", "a") { |f| f.write(new_profile.to_yaml) }
  when :practice
    practice_drill
  end
end

def practice_drill
  prompt = TTY::Prompt.new

  max_size = prompt.ask('Maximum bet size?') do |q|
    q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
    q.convert :int
  end

  max_bets = prompt.ask('Maximum number of bets?') do |q|
    q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
    q.convert :int
  end

  # timed = prompt.yes?('Would you like a timed challenge?')
  #
  # if timed
  #   drill_time = prompt.ask('How long do you want to drill? (in seconds)') do |q|
  #     q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
  #     q.convert :int
  #   end
  # end

  time_limit = prompt.yes?('Do you want a time limit?')

  if time_limit
    time_limit = prompt.ask('How long to solve?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  drill(max_bets, max_size, time_limit)
end

# timer = Timer.new(drill_time) { throw :challenge_results }
#
# timer.start
#
# catch :challenge_results
