# frozen_string_literal: true

# module for saving and loading game files
module GameSaver
  def save_game
    saving_output
    Dir.mkdir('saved_files') unless Dir.exist?('saved_files')
    yaml = YAML.dump(self)
    filename = random_filename
    File.open(filename, 'w') do |file|
      file.puts yaml
    end
  end

  def random_filename
    description = %w[big hairy smelly stinky heavy hungry]
    item = %w[dog baby goblin lady man wizard]
    "saved_files/#{(description.sample(1) + item.sample(1) + [rand(1..99)]).join('_')}.yaml"
  end

  def show_saved_files
    saves = Dir.glob('saved_files/*')
    puts saves
    select_load
  end

  def select_load
    puts 'Type the entire file name to load up your saved game.'
    selected_file = gets.chomp
    until File.file?(selected_file)
      puts "That file doesn't exist, try again..."
      selected_file = gets.chomp
    end
    load_game(selected_file)
  end

  def load_game(selected_file)
    saved = File.open(selected_file, 'r')
    loaded_game = YAML.load(saved)
    saved.close
    loaded_game.play_game
  end

  def saving_output
    puts 'Saving your game, please wait...'
    sleep(2)
    puts 'Game Saved!'
    sleep(1)
  end
end
