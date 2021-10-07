# frozen_string_literal: true

# module that provides methods to control the logic of the game
module GameLogic
  def get_clues(master_code, guess_code)
    tmp_master = master_code.clone.split('')
    tmp_guess = guess_code.clone.split('')
    @clues = {}
    @clues[:right] = right_clues(tmp_master, tmp_guess)
    @clues[:wrong_place] = wrong_place_clues(tmp_master, tmp_guess)
  end

  def right_clues(master_code, guess_code)
    right = 0
    master_code.each_with_index do |item, index|
      next unless item == guess_code[index]

      right += 1
      master_code[index] = '*'
      guess_code[index] = '*'
    end
    right
  end

  def wrong_place_clues(master_code, guess_code)
    wrong_place = 0
    guess_code.each_with_index do |item, index|
      next unless item != '*' && master_code.include?(item)

      wrong_place += 1
      replace = master_code.find_index(item)
      master_code[replace] = '='
      guess_code[index] = '='
    end
    wrong_place
  end

end
