require_relative 'code_maker'
require_relative 'code_breaker'

class Game
  def initialize(maker_computer: true, breaker_computer: true)
    @maker = CodeMaker.new(maker_computer)
    @breaker = CodeBreaker.new(breaker_computer)
    @code = @maker.create_code
  end
end

p Game.new
