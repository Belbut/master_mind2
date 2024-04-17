require_relative 'code_maker'
require_relative 'code_breaker'

class Game
  SIZE_OF_CODE = 4
  RANGE_OF_USABLE_NUMBERS = (1..6).freeze
  GOD_VIEW = false # change this if you want to know the code from the start

  attr_accessor :round

  def initialize(maker_computer, breaker_computer)
    @maker = CodeMaker.new(maker_computer)
    @breaker = CodeBreaker.new(breaker_computer)
    @code = @maker.create_code
    p @code if GOD_VIEW
    @round = 1
  end

  def feedback(guess)
    code_copy = @code.dup # Make a copy of the @code array to avoid modifying the original
    guess_copy = guess.dup
    result = { number_of_correct: 0, number_of_partial: 0 }

    guess.each.with_index do |guess_element, index|
      if guess_element == @code[index]
        code_copy.delete_at(code_copy.index(guess_element) || code_copy.length)
        guess_copy.delete_at(index)
        result[:number_of_correct] += 1
      end
    end

    guess_copy.each.with_index do |guess_element, index|
      if code_copy.include? guess_element
        code_copy.delete_at(code_copy.index(guess_element))
        result[:number_of_partial] += 1
      end
    end
    # puts "You got #{number_of_correct} red heads and #{number_of_partial} white heads from the guess"
    print "Your guess feedback: "
    puts "#{'■ ' * result[:number_of_correct]} #{'□ ' * result[:number_of_partial]}"

    result
  end

  def play_round
    puts '_______________________________'
    puts "This is round number #{@round}"
    guess = @breaker.make_guess
    puts "The Guess is : #{guess}"
    feedback(guess)
    guess
  end

  def winner?(guess)
    @code == guess
  end

  def end_game(won)
    puts "______________GAME OVER_______________"
    if won
      puts "The code Breaker won the game in #{@round}, congratulations!"
    else
      puts " You didn't discover the code. The code was #{@code}"
    end
  end

  def self.play
    maker_computer = Game.prompt_for_player('Code Maker')
    breaker_computer = Game.prompt_for_player('Code Breaker')
    game = Game.new(maker_computer, breaker_computer)

    12.times do
      guess = game.play_round

      if game.winner?(guess)
        game.end_game(true)
        return
      end
      game.round += 1
    end
    game.end_game(false)
  end

  # prompt will return true if the intention is for the computer to assume the position
  def self.prompt_for_player(job)
    puts "Do you want the #{job} to be played by the computer? Y/N ?"
    loop do
      answer = gets.chomp.capitalize

      return true if answer == 'Y'
      return false if answer == 'N'

      puts "Sorry i didn't understood"
    end
  end
end

a = Game.play