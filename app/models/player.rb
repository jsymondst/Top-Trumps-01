class Player < ActiveRecord::Base

    PROMPT = TTY::Prompt.new
    
    has_many :game_records
    has_many :decks, through: :game_records

    def self.player_names
        Player.all.map {|player| player.name}
    end

    def self.select_a_player

        puts "Please select a player."
        player_names = Player.all.map {|player| player.name}

        context = "Available players: "
        options = player_names

        selection = PROMPT.select(context,options)
        
        Player.find_by(name: selection)

    end
       
    
    def self.create_or_select_a_player
        
        player_names = Player.all.map {|player| player.name}

        options = player_names.unshift("New")
        context = "Please select a player."

        selection = PROMPT.select(context,options)

        if selection == "New"
            name = PROMPT.ask("New player name: ")
            player = Player.create(name: name)
        else
            player = Player.find_by(name: selection)
        end

        player   
        
    end

    def self.manage_players
        system("clear")
        context = "Select a player to delete."
        options = player_names << "BACK"
        
        selection = PROMPT.select(context, options)

        if selection == "BACK"
            Menu.root_menu
        else
            player = Player.find_by(name: selection)
            confirmation = PROMPT.ask("Are you sure you want to delete #{player.name}?\n Please type 'DELETE' to confirm. \n")
            if confirmation.upcase == "DELETE"
                name = player.name
                player.destroy
                PROMPT.keypress("Deleted #{name}. Returning to main menu.", timeout:2)
                Menu.root_menu
            else
                PROMPT.keypress("Delete cancelled. Returning to main menu.", timeout:2)
                Menu.root_menu
            end
        end
    end
end