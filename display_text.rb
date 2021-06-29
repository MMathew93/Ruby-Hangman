# frozen_string_literal: true

# module for text to save line space
module DisplayText
  def start_load
    <<~HEREDOC
      How to play Hangman:

      A random word with 5-12 letters will be chosen.#{' '}
      On each turn, you can guess one letter.#{' '}
      To win, you must find all the letters in the word#{' '}
      before running out of guesses.

      Would you like to: [1] Start a new game
                         [2] Load a game
                         [3] Quit game
    HEREDOC
  end

  def selected_word
    <<~HEREDOC
      Your random word has been selected, it has:#{' '}
    HEREDOC
  end

  def quit_game
    <<~HEREDOC
      Thanks for playing my hangman game!#{' '}
    HEREDOC
  end

  def guess_text
    <<~HEREDOC
      Guess a letter, or you can type 'save' to save your game for later!
      Type 'exit' to quite out of the game, remember to save!
    HEREDOC
  end

  def winner_text
    <<~HEREDOC
      WINNER WINNER CHICKEN DINNER!
      Do you want to play again? y/n?
    HEREDOC
  end

  def loser_text
    <<~HEREDOC
      Aw darn, better luck next time...
      Do you want to play again? y/n?
    HEREDOC
  end
end
