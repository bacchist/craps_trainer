# coding: utf-8
# frozen_string_literal: true

class Interface
  def initialize
    @prompt = TTY::Prompt.new
    @font = TTY::Font.new(:standard)
    @color = Pastel.new
    @prompt.on(:keypress) do |event|
      if event.value == 'Q'
        abort 'Thanks for playing'
      end
    end
  end

  def defaults?
    puts @color.green(@font.write('CRAPS TRAINER'))
    @prompt.yes?('Use default options?')
  end

  def max_bets
    @prompt.ask('Maximum number of bets?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  def max_size
    @prompt.ask('Maximum bet size?') do |q|
      q.validate(/^([1-9]+)\d*$/, 'Must be a positive integer.')
      q.convert :int
    end
  end

  def irregular
    @prompt.no?('Do you want to include irregular bets?')
  end

  def answer
    @prompt.ask('What is the payout?') do |q|
      q.convert :int
    end
  end

  def red(str)
    puts @color.red(str)
  end
end
