class Game
    
    PROMPT = TTY::Prompt.new
    
    attr_reader :deck, :player, :player_stack, :ai_stack
    attr_accessor :player_points, :ai_points, :headers, :table_headers
    
    def initialize (deck:, player:)
        @player = player
        @deck = deck
        @player_points = 0
        @ai_points = 0
    end

    #newgame = Game.new
    #newgame.run

    def run
        puts "win or lose?"
        input = STDIN.gets.chomp.downcase
        
        case input
        when "win"
            GameRecord.create(player_id:player.id, deck_id:deck.id, win:1, loss: 0)
        when "lose"
            GameRecord.create(player_id:player.id, deck_id:deck.id, win:0, loss: 1)
        end
    end

    def self.start(deck:, player:)
        new_game = self.new(deck: deck,player: player)
        # new_game.deal
        new_game.play
    end


       
    def deal
        Card.import_deck(deck) #REMEMBER TO CHANGE THIS!
        stack = Card.all.shuffle
        @player_stack = stack[0 ... (stack.length/2)]
        @ai_stack = stack[(stack.length/2) .. stack.length]
        @headers = Card.headers
        @table_headers = Card.table_headers
        PROMPT.keypress("Dealt each player #{@player_stack.length} cards.", timeout: 3)
        
    end

    def player_clash
        #clear
        #Show me my card (and current points)
        #I choose a stat
        #compete
        #Show result
        #tally the point

        system("clear")
        
        puts "Your Points: #{player_points} | Opponents Points: #{ai_points}"
        puts "Your card:"

        player_card = self.player_stack.shift
        ai_card = self.ai_stack.shift
        player_card_values = player_card.card_values
        ai_card_values = ai_card.card_values
        
        card_table = TTY::Table.new table_headers, [player_card_values]

        puts card_table.render(:ascii)

        prompt = "Select a stat from 1 to #{deck.playable_columns}"
        options = (1..deck.playable_columns).map{|index|index.to_s}

        selected = false
        while !selected do
            puts prompt
            input = STDIN.gets.chomp
            selected = options.include?(input)
        end
        input = input.to_i

        player_value = player_card_values[input].to_f
        ai_value = ai_card_values[input].to_f

        player_results = ["Your Card:", player_card.name + "  ", headers[input]+":", player_value]
        ai_results = ["Their Card:", ai_card.name+ "  ", headers[input]+":", ai_value]

        result_table = TTY::Table.new(player_results, [ai_results])

        puts result_table.render

        if player_value > ai_value
            puts "You won!"
            self.player_points += 1
        elsif player_value < ai_value
            puts "You Lost."
            self.ai_points += 1
        else
            puts "It was a Draw!"
        end

        PROMPT.keypress("", timeout: 3)

    end


    def play
        #Say it's time to play
        system ("clear")
        puts "Okay #{player.name}, it's time to test your knowledge of #{deck.name}."
        puts "We'll keep going to 5 points."
        PROMPT.keypress("Ready?", timeout: 2)
        self.deal

        result = nil
        binding.pry
        while !result do
            self.player_clash
            if player_points == 5
                result = "win"
            elsif ai_points == 5
                result = "loss"
            end
        end

        case result
        when "win"
            system("clear")
            puts "Congratulations, You win!\n "
            puts "Final Score:"
            puts "Player: #{player_points} | Opponent: #{ai_points}\n "

            GameRecord.create(player_id: player.id, deck_id: deck.id,  win: 1, loss: 0)
            sleep(2)
        when "loss"
            system("clear")
            puts "You lost. Unlucky.\n "
            puts "Final Score:"
            puts "Player: #{player_points} | Opponent: #{ai_points}\n "
            
            GameRecord.create(player_id: player.id, deck_id: deck.id,  win: 0, loss: 1)
            sleep(2)
        end
        
        #Option: play again / main menu / exit
        
        context = "Would you like to play again?"
        options = ["Play Again", "Main Menu", "Exit"]

        selection = PROMPT.select(context, options)

        case selection
        when "Play Again"
            puts "Okay, let's go again"
            sleep(1.5)
            Game.start(deck: self.deck, player: self.player)
        when "Main Menu"
            puts "Returning to main menu"
            sleep(1.5)
            Menu.root_menu
        when "Exit"
            puts "Bye!"
            exit
        end
        
    end

    def self.dummygame
        new_game = self.new(deck: Deck.second, player:Player.first)
        new_game.deal
        new_game
    end




end
