def get_user_inputs
  prompt = TTY::Prompt.new
  max_size = prompt.ask('Maximum bet size?') do |q|
    q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
    q.convert :int
  end

  max_bets = prompt.ask('Maximum number of bets?') do |q|
    q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
    q.convert :int
  end

  timed = prompt.yes?('Would you like a timed challenge?')

  if timed
    drill_time = prompt.ask('How long do you want to drill? (in seconds)') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  drill(max_bets, max_size, drill_time)
end
