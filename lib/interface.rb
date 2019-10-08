# frozen_string_literal: true

class Interface
  def initialize
    @p = TTY::Prompt.new
  end

  def max_bets
    @p.ask('Maximum number of bets?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  def max_size
    @p.ask('Maximum bet size?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  def time
    timed = @p.yes?('Would you like a timed challenge?')

    if timed
      @drill_time = @p.ask('How long do you want to drill? (in seconds)') do |q|
        q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
        q.convert :int
      end
    end
  end

  def answer
    @p.ask('What is the payout?') do |q|
      q.convert :int
    end
  end
end
