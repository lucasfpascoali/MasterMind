require './display'
require './game_logic'
require 'set'

class CodeMaker
  include Display
  include GameLogic

  def initialize
    colors = '123456'.chars
    @all_answers = colors.product(*[colors] * 3).map(&:join)
    @all_scores = Hash.new { |h, k| h[k] = {} }

    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = calculate_score(guess, answer)
    end

    @all_answers = @all_answers.to_set
  end

  def play
    @guesses = 1
    ask_maker_code
    @answer = player_code
    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup
    play_turn
  end

  private

  def play_turn
    while @guesses <= 12
      puts "Computer Turn #{@guesses}"
      @guess = make_guess
      @guesses += 1
      @score = calculate_score(@guess, @answer)
      show_code(@guess.split(''))
      get_clues(@answer.split(''), @guess.split(''))
      show_clues(@clues[:right], @clues[:wrong_place])
      if @score == 'BBBB'
        puts 'The computer broke the code!'
        break
      end
    end
  end

  def make_guess
    if @guesses > 1
      @possible_answers.keep_if { |answer| @all_scores[@guess][answer] == @score }
      guesses = @possible_scores.map do |guess, scores_by_answer|
        scores_by_answer = scores_by_answer.select { |answer, _| @possible_answers.include?(answer) }
        @possible_scores[guess] = scores_by_answer

        scores_groups = scores_by_answer.values.group_by(&:itself)
        possibility_counts = scores_groups.values.map(&:length)
        worst_case_possibilities = possibility_counts.max
        impossible_guess = @possible_answers.include?(guess) ? 0 : 1
        [worst_case_possibilities, impossible_guess, guess]
      end

      guesses.min.last
    else
      '1122'
    end
  end

  def calculate_score(guess, answer)
    score = ''
    wrong_guess_pegs = []
    wrong_answer_pegs = []
    peg_pairs = guess.chars.zip(answer.chars)

    peg_pairs.each do |guess_peg, answer_peg|
      if guess_peg == answer_peg
        score << 'B'
      else
        wrong_guess_pegs << guess_peg
        wrong_answer_pegs << answer_peg
      end
    end
    wrong_guess_pegs.each do |peg|
      if wrong_answer_pegs.include?(peg)
        wrong_answer_pegs.delete(peg)
        score << 'W'
      end
    end

    score
  end

  def player_code
    code = gets.chomp.split('')
    return code.join if code_valid?(code)

    invalid_code
    player_code
  end

  def code_valid?(code)
    return false unless code.length == 4

    code.all? { |number| number.to_i.between?(1, 6) }
  end
end
