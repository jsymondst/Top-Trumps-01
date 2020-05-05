class Menu

    def self.splash
        puts "WELCOME TO TOP TRUMPS!"
        puts "built by Zack and Jamie"
    end

    def self.root_menu
        puts "What would you like to do?"
        puts "PLAY to play the game."
        puts "STATS to see player and deck stats"
        puts "EXIT to leave the game"
           
        valid_input = false
        
        while !valid_input do        
        
            input = gets.chomp
            downcase_input = input.downcase # make lowercase
              
            case downcase_input
                when "play"
                    valid_input = true
                    puts "Going to play menu!"
                    # play_menu
                when "stats"
                    valid_input = true
                    puts "Stats are fun too!"
                    # stats_menu
                when "exit", "quit"
                    valid_input = true
                    puts "Bye!"
                    exit
                else
                    puts "Sorry, I didn't understand #{input}, please try PLAY, STATS or EXIT."
            end
        end
    end
    def self.play_menu

        player_id = select_player
        deck_id = select_deck

        puts "Starting a new game with deck_id #{deck_id} and player_id #{player_id}."

        # Game.new(player_id, deck_id)
                        
    end

    def self.select_player

        players = ["zack", "jamie"]        
        
        puts "Select a player or type new for a new player"      
        puts players

        player_id = nil
        
        while !player_id
            
            input = gets.chomp            
            
            if input == "New"
                puts "Please input your new player's name"
                new_player = gets.chomp
                puts "Created new player #{new_player}"
                players << new_player
                player_id = players.find_index(input)
                puts "Playing as #{input}"
            elsif players.include?(input)
                player_id = players.find_index(input)
                puts "Playing as #{input}"
                
                # player_object = Player.find_by_name(downcase_input)
                # player_id = player_object.id
            else 
                puts "I can't find player #{input}. Please try again or type new to create a new player"
            end
        end

        player_id

    end

    def self.select_deck
        decks = ["simpsons", "harrypotter"]        
        puts "Select a deck. \n"
        puts decks

        deck_id = nil
        
        while !deck_id
            
            input = gets.chomp
                        
            if decks.include?(input)
                deck_id = decks.find_index(input)
                puts "Playing with the \'#{input}\' deck"
                
                # deck_object = deck.find_by_name(downcase_input)
                # deck_id = deck_object.id
            else 
                puts "I can't find deck #{input}. Please try again."
            end
        end

        deck_id

    end


end

Menu.splash

# Menu.root_menu



Menu.play_menu

