# frozen_string_literal: true

require './display'
require './game_logic'
require './code_breaker'
require './code_maker'

# Control the game
class Game
  include Display
  include GameLogic

  attr_reader :mode

  def initialize
    ask_mode
    @mode = mode_selection
    @mode == '1' ? code_maker : code_breaker
  end

  private

  def mode_selection
    mode = gets.chomp
    return mode if %w[1 2].include?(mode)

    invalid_mode
    mode_selection
  end

  def code_maker
    maker = CodeMaker.new
    maker.play
  end

  def code_breaker
    breaker = CodeBreaker.new
    breaker.play
  end
end
