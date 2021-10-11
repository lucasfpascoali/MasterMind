# frozen_string_literal: true

require './display'
require './game_logic'

# Code Breaker Mode
class CodeBreaker
  include Display
  include GameLogic

  def initialize
    @win = false
    @master_code = 4.times.map { %w[1 2 3 4 5 6].sample }
  end

  def play
    turns
    game_over unless @win
  end

  private

  def turns
    turn = 1
    while turn <= 12
      breaker_turn_description(turn)
      guess = player_guess
      show_code(guess)

      win_verify(guess)
      break if @win

      get_clues(guess, @master_code)
      show_clues(@clues[:right], @clues[:wrong_place])
      turn += 1
    end
  end

  def game_over
    puts 'You loose ;-;'
    puts 'Here is the master code:'
    show_code(@master_code)
    puts ''
  end

  def win_verify(guess)
    @win = true if guess == @master_code
    puts 'You broke the code!' if @win
  end

  def player_guess
    guess = gets.chomp.split('')
    return guess if guess_valid?(guess)

    invalid_code
    player_guess
  end

  def guess_valid?(guess)
    return false unless guess.length == 4

    guess.all? { |number| number.to_i.between?(1, 6) }
  end

end
