# frozen_string_literal: true

require_relative 'display_text'
require_relative 'game_saver'
require 'yaml'
# Class for the game
class Game
  attr_accessor :guessed_letters, :random_word, :hidden_word, :misses

  include DisplayText
  include GameSaver

  def initialize
    @player_option = nil
    @random_word = nil
  end

  def start
    puts start_load
    player_option = gets.chomp.to_i
    until [1, 2, 3].include?(player_option)
      puts "That's not an option, please try again..."
      player_option = gets.chomp.to_i
    end
    player_selection(player_option)
  end

  def player_selection(mode)
    case mode
    when 1, 'y'
      initialize_game
    when 2
      show_saved_files
    else
      puts quit_game
      exit
    end
  end

  def initialize_game
    random_word_from_dictionary
    @hidden_word = ['_'] * random_word.length
    @guessed_letters = []
    @misses = 7
    play_game
  end

  def play_game
    game_display
    player_input
  end

  # select a random word for game
  def random_word_from_dictionary
    dictionary = File.readlines('5desk.txt')
    cleaned_dictionary = dictionary.each(&:strip!).select { |word| word.length.between?(5, 12) }
    @random_word = cleaned_dictionary[rand(0..cleaned_dictionary.length)].downcase
    puts selected_word
    puts "#{random_word.length} letters, Good Luck!"
  end

  # display the current status of game
  def game_display
    puts "Number of misses left: #{misses}"
    p guessed_letters
    puts hidden_word.join
  end

  # get the player input
  def player_input
    puts guess_text
    input = gets.chomp.to_s.downcase
    until ('a'..'z').include?(input) || input == 'save' || input == 'exit'
      puts "That's not an option! Please guess a letter..."
      input = gets.chomp.to_s.downcase
    end
    player_options(input)
  end

  # check player input to see which option was input
  def player_options(input)
    case input
    when 'save'
      save_game
      game_over
    when 'exit'
      puts quit_game
      exit
    else
      verify_letter_guess(input)
    end
  end

  def verify_letter_guess(letter)
    if random_word.include?(letter)
      # update hidden word display
      random_word.chars.each_with_index do |element, i|
        @hidden_word[i] = letter if element == letter
      end
    else
      # check if guess has ben stated before
      guessed_letter_checker(letter)
    end
    # check if game is over and either end or repeat
    game_over
  end

  def guessed_letter_checker(letter)
    if guessed_letters.include?(letter)
      nil
    else
      guessed_letters << letter
      @misses -= 1
    end
  end

  def game_over
    if hidden_word.join == random_word
      puts winner_text
      play_again
    elsif misses.zero?
      puts loser_text
      play_again
    else
      # allow player to guess again
      play_game
    end
  end

  def play_again
    input = gets.chomp.downcase
    until %w[y n].include?(input)
      puts "That's not an option!"
      input = gets.chomp.to_s.downcase
    end
    player_selection(input)
  end
end
