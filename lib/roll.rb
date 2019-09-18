class Roll
  def initialize
    @a = []
	  2.times { @a.push(rand(1..6)) }
  end

  def reroll
    @a = []
	  2.times { @a.push(rand(1..6)) }
	  @a
  end

  def result
    @a
  end

  def name
    ROLL_NAMES.find { |key, values|
      values.include?(@a.sort)
    }.first
  end
  
  def is_hard?
    @a.uniq.length == 1
  end
  
  def is_seven?
    BET_TYPES["Seven"].include? @a.name
  end
end