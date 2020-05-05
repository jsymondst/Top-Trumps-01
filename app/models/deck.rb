class Deck < ActiveRecord::Base

    has_many :game_records
    has_many :players, through: :game_records
    
    def self.select_a_deck
        puts "Please select a deck."
        deck_names = Deck.all.map {|deck| deck.name}
        puts "Available decks: "
        puts deck_names
        
        valid_input = false
        options = deck_names << "EXIT"
        while !valid_input do
            input = STDIN.gets.chomp          
            if options.include?(input)
                valid_input = true
            else
                print "Sorry I don't understand #{input}, please try " 
                options.each{|option| print "#{option} "}
                print "\n"
            end
        end

        if input == "EXIT"
            puts "Bye!"
            exit
        else
            Deck.find_by(name: input)
        end
    end

end