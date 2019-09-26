def round(chips)                  # Rounds like a casino.
  if chips - chips.to_i < 0.75
    chips.to_i
  else
    chips = chips.ceil
  end
end

def calculate_payout(winner, roll)
  if winner.exceptional?
    case winner.exception
      when "Crap Check"
        if winner.type == "C & E" && roll.name == :yo
          return winner.wager * 6.5
        elsif winner.type == "C & E"
          return winner.wager * 3
        elsif roll.name == :aces || roll.name == :ace_deuce || roll.name == :twelve
          return winner.wager * 7
        end
      when "Red"
        if winner.type == "Seven/Eleven" && roll.name == :seven
          return winner.wager * 1.5
        elsif winner.type == "Seven/Eleven"
          return winner.wager * 6.5
        else
          return winner.wager * 4
        end
      when "Horn High"
        if winner.type == "Horn High Aces" && roll.name == :aces
          return round(30 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Ace-Deuce" && roll.name == :ace_deuce
          return round(15 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Yo" && roll.name == :yo
          return round(15 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        elsif winner.type == "Horn High Twelve" && roll.name == :twelve
          return round(30 * (2 * winner.wager.to_f / winner.ways) - winner.wager)
        end
    end
  end
  if winner.type == "World Bet" && roll.name == :seven
    return 0
  end
  h = roll.is_hard? ? 30 : 15
  w = winner.wager.to_f / winner.ways
  round(h * w - winner.wager)
end


def wins_and_losses(working, roll)
  winnings = 0
  working.each { |wb|
    if wb.winners.include?(roll.name)
	    winnings = winnings + calculate_payout(wb, roll)
    else
	    winnings = winnings - wb.wager
    end
  }
  winnings
end
