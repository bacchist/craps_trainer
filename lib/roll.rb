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
end
