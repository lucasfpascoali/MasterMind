# frozen_string_literal: true

# Module: Display information about the game
module Display
  # MODE
  def ask_mode
    puts 'Which mode you would like to be? Maker or Code Breaker?'
    puts 'Type one of the options below: '
    puts '1- MAKER'
    puts '2- BREAKER'
  end

  def invalid_mode
    puts 'Type one of the options: 1 or 2'
  end

  # MAKER
  def ask_maker_code
    puts 'Type 4 numbers between 1-6 to make a code'
  end

  # BREAKER
  def breaker_turn_description(turn)
    puts "Turn #{turn}: Type 4 numbers between 1-6 to guess the code"
  end

  # BOTH MODES
  def invalid_code
    puts 'Type only 4 numbers between 1-6'
  end

  # OUTPUTS
  def code_colors(number)
    {
      '1' => "\e[101m  1  \e[0m ",
      '2' => "\e[43m  2  \e[0m ",
      '3' => "\e[44m  3  \e[0m ",
      '4' => "\e[45m  4  \e[0m ",
      '5' => "\e[46m  5  \e[0m ",
      '6' => "\e[41m  6  \e[0m "
    }[number]
  end

  def clue_colors(clue)
    {
      '*' => "\e[91m\u25CF\e[0m ",
      '?' => "\e[37m\u25CB\e[0m "
    }[clue]
  end

  def show_code(array)
    array.each do |num|
      print code_colors num
    end
  end

  def show_clues(exact, same)
    print '  Clues: '
    exact.times { print clue_colors('*') }
    same.times { print clue_colors('?') }
    puts ''
  end
end
