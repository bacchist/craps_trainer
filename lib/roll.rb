# frozen_string_literal: true

class Roll < Array

  def initialize
    2.times { push(rand(1..6)) }
  end

  def roll
    clear
    2.times { push(rand(1..6)) }
    self
  end

  def name
    ROLL_NAMES.find { |_k, v| v.include?(sort) }.first
  end

  def to_s
    "#{DICE[self[0] - 1]} #{DICE[self[1] - 1]}"
  end
end
