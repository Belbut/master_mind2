class ComputerMaker
  def initialize; end

  def create_code
    Array.new(CodeMaker::SIZE_OF_CODE) { rand(CodeMaker::RANGE_OF_USABLE_NUMBERS) }
  end
end

class PlayerMaker
  def initialize; end

  def create_code
    puts 'Hello Mastermind'
    loop do
      puts "Pick #{CodeMaker::SIZE_OF_CODE} numbers between #{CodeMaker::RANGE_OF_USABLE_NUMBERS} to make your code:"
      code = gets.chomp.split('')
      code.map!(&:to_i)

      return code if code.size == CodeMaker::SIZE_OF_CODE && code.all? do |n|
                       CodeMaker::RANGE_OF_USABLE_NUMBERS.include?(n)
                     end

      puts "That wasn't a proper code"
    end
  end
end

class CodeMaker
  SIZE_OF_CODE = 4
  RANGE_OF_USABLE_NUMBERS = (1..6).freeze

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
