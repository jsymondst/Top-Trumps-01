class Player < ActiveRecord::Base

    has_many :game_records
    has_many :decks, through: :game_records

    def self.select_a_player
        puts "Please select a player or type NEW for a new player."
        player_names = Player.all.map {|player| player.name}
        puts "Available players: "
        puts player_names
        
        valid_input = false
        while !valid_input do
            input = STDIN.gets.chomp            
            options = player_names.concat(["NEW"])
            if options.include?(input)
                valid_input = true
            else
                print "Sorry I don't understand #{input}, please try " 
                options.each{|option| print "#{option} "}
                print "\n"
            end
        end

        if input == "NEW"
            #request a name
            puts "Please input a player name:"
            name_input = STDIN.gets.chomp
            #create a player
            selected_player = Player.create(name: name_input)
            #return that player
            puts "Created player #{name_input}."
        else
            # return the right player
            selected_player = Player.find_by(name: input)
            "Selected #{input}."
        end

        selected_player
        
    end
end