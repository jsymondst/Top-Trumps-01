class Menu

    PROMPT = TTY::Prompt.new

    def self.splash
        system("clear")
        splash_art =  File.read("./bin/splash_art.txt")
        puts splash_art
        PROMPT.keypress("Press any key to continue", timeout:5)
    end

    def self.root_menu
        system("clear")
        context = "Main Menu"
        options = ["Play", "Stats", "Manage Players", "Exit"]

        selection = PROMPT.select(context,options)
           
        case selection
            when "Play"
                play_menu
            when "Stats"
                Stats.menu
            when "Manage Players"
                Player.manage_players
            when "Exit"
                puts "Bye!"
                exit
        end
        
    end
    def self.play_menu
        player = Player.create_or_select_a_player
        deck = Deck.select_a_deck

        #Confirm readiness
        context = "Player: #{player.name}, Deck: #{deck.name}. Ready to start?"
        options = ["Play", "Main Menu"]
        
        selection = PROMPT.select(context, options)
        case selection
            when "Play"
                Game.start(player:player, deck:deck)
            when "Main Menu"
                root_menu
        end         
    end

    
end
