class Bet
  attr_accessor :type, :wager

  def initialize(type, wager)
    @type = type
    normalize_bet_size(wager)
  end

  def winners
    BET_TYPES[@type]
  end

  def ways
    ws = 0
    if self.exception == "Horn High"
      return 5
    elsif @type == "C & E"
      return 2
    elsif @type == "Crap Check"
      return 1
    end
	  winners.each do |w|
      ws = ws + (w == :seven ? 1 : ROLL_NAMES[w].count)
    end
	  ws
  end

  def exceptional?
    ALT_PAYOUTS.each { |k, v|
      if v.include?(@type)
        return true
      end
    }
    return false
  end

  def exception
    ALT_PAYOUTS.each { |k, v| return k if v.include?(@type) }
  end

  private

    def normalize_bet_size(wager)
      if wager < self.ways
        @wager = self.ways
      elsif wager % self.ways != 0 && wager % 5 != 0
        wager -= 1 until (wager % self.ways == 0 || wager % 5 == 0)
        @wager = wager
      else
        @wager = wager
      end
    end
end
