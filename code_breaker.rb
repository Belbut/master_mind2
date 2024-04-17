class ComputerBreaker
  def initialize; end

  def make_guess
    Array.new(Game::SIZE_OF_CODE) { rand(Game::RANGE_OF_USABLE_NUMBERS) }
  end
end

class PlayerBreaker < Player
  def initialize
    super
  end

  def make_guess
    pick_code('Make a guess:')
  end
end

class CodeBreaker
  def initialize(is_computer)
    @breaker = if is_computer
                 ComputerBreaker.new
               else
                 PlayerBreaker.new
               end
  end

  def make_guess
    @breaker.make_guess
  end
end
