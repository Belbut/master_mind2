require_relative 'player'

class ComputerMaker
  def initialize; end

  def create_code
    Array.new(Game::SIZE_OF_CODE) { rand(Game::RANGE_OF_USABLE_NUMBERS) }
  end
end

class PlayerMaker < Player
  def initialize
    super
  end

  def create_code
    puts 'Hello Mastermind'
    pick_code("Pick #{Game::SIZE_OF_CODE} numbers between #{Game::RANGE_OF_USABLE_NUMBERS} to make your code:")
  end
end

class CodeMaker
  def initialize(is_computer)
    @maker = if is_computer
               ComputerMaker.new
             else
               PlayerMaker.new
             end
  end

  def create_code
    @maker.create_code
  end
end
