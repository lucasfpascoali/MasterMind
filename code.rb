
require './display'

# Control the values of the code
class Code
  include Display

  attr_reader :code

  def initialize(mode)
    @code = mode == '1' ? user_code : generate_code
  end

  def user_code
    code = ''
    ask_maker_code
    loop do
      code = gets.chomp
      break if valid_code?(code)

      invalid_maker_code
    end
    code
  end

  private

  def generate_code
    code = ''
    4.times { code += Random.rand(1..6).to_s }
    code
  end

  def valid_code?(code)
    return false unless code.length == 4

    code.split('').all? { |i| i.to_i.between?(1, 6) }
  end
end
