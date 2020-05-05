class Game
    attr_reader :deck, :player, :player_stack, :ai_stack
    attr_accessor :player_points, :ai_points, :headers
    
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
        new_game.deal
        new_game.play
    end


       
    def deal
        Card.import_deck("hi") #REMEMBER TO CHANGE THIS!
        stack = Card.all.shuffle
        @player_stack = stack[0 ... (stack.length/2)]
        @ai_stack = stack[(stack.length/2) .. stack.length]
        @headers = Card.headers
        puts "Dealt each player #{@player_stack.length} cards."
        
    end

    def player_clash
        #Show me my card
        #I choose a stat
        #compete
        #tally the point

        puts "Your card:"

        player_card = self.player_stack.shift
        ai_card = self.ai_stack.shift
        player_card_values = [player_card.name, player_card.val1, player_card.val2, player_card.val3, player_card.val4, player_card.val5, player_card.val6]
        ai_card_values = [ai_card.name, ai_card.val1, ai_card.val2, ai_card.val3, ai_card.val4, ai_card.val5, ai_card.val6]
        
        table_headers = ["Name", "1. #{headers[1]}", "2. #{headers[2]}", "3. #{headers[3]}", "4. #{headers[4]}", "5. #{headers[5]}", "6. #{headers[6]}"]
        card_table = TTY::Table.new table_headers, [player_card_values]

        puts card_table.render(:ascii)

        selected = false
        while !selected do
            puts "Select a stat from 1 to 6"
            input = STDIN.gets.chomp
            selected = ["1","2","3","4","5","6"].include?(input)
        end
        input = input.to_i

        player_value = player_card_values[input].to_f
        ai_value = ai_card_values[input].to_f

        puts "Your card: #{player_card.name}: #{headers[input]}: #{player_value}"
        puts "Opponent's card: #{ai_card.name}: #{headers[input]}: #{ai_value}"

        if player_value > ai_value
            puts "You won!"
            self.player_points += 1
            puts "Your points: #{self.player_points}"
            puts "Opponent's points: #{self.ai_points}"
        elsif player_value < ai_value
            puts "You Lost."
            self.ai_points += 1
            puts "Your points: #{self.player_points}"
            puts "Opponent's points: #{self.ai_points}"
        else
            puts "It was a Draw!"
            puts "Your points: #{self.player_points}"
            puts "Opponent's points: #{self.ai_points}"
        end

    end


    def play
        #Say it's time to play
        puts "Okay #{player.name}, it's time to test your knowledge of #{deck.name}."
        puts "We'll keep going to 5 points."
        puts "Ready?"

        result = nil
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
            puts "Congratulations, You win!"
            GameRecord.create(player_id: player.id, deck_id: deck.id,  win: 1, loss: 0)
        when "loss"
            puts "You lost. Unlucky."
            GameRecord.create(player_id: player.id, deck_id: deck.id,  win: 0, loss: 1)
        end
        
        #Option: play again / main menu / exit
        puts "Would you like to play again? Y / N / EXIT"

        valid_input = false
        while !valid_input do
            input = STDIN.gets.chomp.upcase            
            options = options = ["Y", "N", "EXIT"]
            if options.include?(input)
                valid_input = true
            else
                print "Sorry I don't understand #{input}, please try " 
                options.each{|option| print "#{option.upcase} "}
                print "\n"
            end
        end

        case input
        when "Y"
            puts "Okay, let's go again"
            Game.start(deck: self.deck, player: self.player)
        when "N"
            puts "Returning to main menu"
            Menu.root_menu
        when "EXIT"
            puts "Bye!"
            exit
        end
    end

    def self.dummygame
        new_game = self.new(deck: Deck.first, player:Player.first)
        new_game.deal
        new_game
    end




end
