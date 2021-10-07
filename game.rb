# frozen_string_literal: true

require './code'
require './mode'
require './display'
require './game_logic'

# Control the game
class Game
  include Display
  include GameLogic

  attr_reader :master_code, :mode, :turn

  def initialize
    @mode = Mode.new
    @master_code = Code.new(mode.mode)
    @turn = 1
  end

  def play
    if @mode.mode == 1
      turns(:maker_turn_description, :play_as_maker, :maker_outputs)
    else
      turns(:breaker_turn_description, :play_as_breaker?, :breaker_outputs)
    end
  end

  private

  def play_as_maker
    # TO DO
  end

  def play_as_breaker?
    user_input = master_code.user_code
    show_code(user_input.split(''))
    return true if user_input == master_code.code

    get_clues(user_input, master_code.code)
    clues = @clues
    show_clues(clues[:right], clues[:wrong_place])
    false
  end

  # The first parameter will be a method of the display module that will be executed at the beginning of each turn
  # The second parameter will be a method that will control how the game mode works
  def turns(method_display, method_execution, outputs)
    user_win = false
    until turn > 12
      method(method_display).call(turn)
      user_win = method(method_execution).call
      break if user_win

      @turn += 1
    end
    method(outputs).call(user_win, master_code.code)
  end
end
