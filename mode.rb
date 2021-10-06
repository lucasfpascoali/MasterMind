# frozen_string_literal: true

require './display'

# Gets input from user to define the game mode
class Mode
  include Display

  attr_reader :mode

  def initialize
    ask_mode
    @mode = user_mode
  end

  private

  def user_mode
    mode = ''
    loop do
      mode = gets.chomp
      break if %w[1 2].include?(mode)

      invalid_mode
    end
    mode
  end
end
