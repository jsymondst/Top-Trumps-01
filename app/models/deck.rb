class Deck < ActiveRecord::Base

    PROMPT = TTY::Prompt.new
    
    has_many :game_records
    has_many :players, through: :game_records
    
    def self.select_a_deck
        puts "Please select a deck."
        deck_names = Deck.all.map {|deck| deck.name}

        context = "Available decks: "
        options = deck_names

        selection = PROMPT.select(context,options)
        
        Deck.find_by(name: selection)
        
    end

end