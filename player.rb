class Player
  def initialize; end

  def pick_code(message)
    loop do
      puts message
      code = gets.chomp.split('')
      code.map!(&:to_i)

      return code if code.size == Game::SIZE_OF_CODE && code.all? do |n|
                       Game::RANGE_OF_USABLE_NUMBERS.include?(n)
                     end

      puts "That wasn't a proper code"
    end
  end
end
