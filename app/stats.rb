class Stats
    def self.menu
        puts "Would you like PLAYER, DECK or RANKING stats? MENU returns to main menu."
        
        valid_input = false
        while !valid_input do
            input = STDIN.gets.chomp.upcase            
            options = ["PLAYER","DECK", "RANKING", "MENU", "EXIT"]
            if options.include?(input)
                valid_input = true
            else
                print "Sorry I don't understand #{input}, please try " 
                options.each{|option| print "#{option.upcase} "}
                print "\n"
            end
        end

        case input
        when "PLAYER"
            player = Player.select_a_player
            player_stats(player)
            menu
        when "DECK"
            deck = Deck.select_a_deck
            deck_stats(deck)
            menu
        when "RANKING"
            rankings
            menu
        when "MENU"
            puts "returning to main menu"
            Menu.root_menu
        when "EXIT"
            puts "Bye!"
            exit
        end
    end

    def self.deck_stats(deck)
        header_row = ["Player Name", "Wins", "Losses", "%"]
        
        result_array = deck.players.uniq.map do |player| 
            
            row_name = player.name
            row_wins = GameRecord.where(player_id: player.id, deck_id: deck.id).sum(:win)
            row_losses = GameRecord.where(player_id: player.id, deck_id: deck.id).sum(:loss)
            win_percentage = ((row_wins * 100.0) / (row_losses + row_wins))
        
            row = [row_name, row_wins, row_losses, win_percentage]
                
        end
        
        results_table = TTY::Table.new header_row, result_array

        puts results_table.render(:ascii)
    end

    def self.player_stats(player)
        header_row = ["Deck Name", "Wins", "Losses", "%"]
        
        result_array = player.decks.uniq.map do |deck| 
            
            row_name = deck.name
            row_wins = GameRecord.where(deck_id: deck.id, player_id: player.id).sum(:win)
            row_losses = GameRecord.where(deck_id: deck.id, player_id: player.id).sum(:loss)
            win_percentage = ((row_wins * 100.0) / (row_losses + row_wins))
        
            row = [row_name, row_wins, row_losses, win_percentage]
                
        end
        
        results_table = TTY::Table.new header_row, result_array

        puts results_table.render(:ascii)
    end

    def self.rankings
        header_row = ["Player Name", "Wins", "Losses", "%"]

        result_array = Player.all.map do |player|

            row_name = player.name
            row_wins = GameRecord.where(player_id: player.id).sum(:win)
            row_losses = GameRecord.where(player_id: player.id).sum(:loss)
            win_percentage = ((row_wins * 100.0) / (row_losses + row_wins))
        
            row = [row_name, row_wins, row_losses, win_percentage]

        end

        result_array = result_array.sort_by{|row| row[3]}
        result_array.reverse!

        results_table = TTY::Table.new header_row, result_array

        puts results_table.render(:ascii)

    end

end

 
