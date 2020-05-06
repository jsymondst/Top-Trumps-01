# require 'csv'
# require 'pry'
class Card < ActiveRecord::Base

    def self.import_deck(deck)
        #use filename later
        # csv_text = File.read(filename)

        @@deck = deck

        Card.destroy_all

        csv_text = File.read(deck.deck_path)
    
        csv_table = csv_text.split("\r\n")

        #set_headers
        header_row = csv_table[0].split(",")
        @@headers = header_row
        @@headers[0] = "Name"
            
        # create the rows
            data_array = csv_table[1 ... csv_table.length].map{|row| row.split(",")}
            data_array.each do |row|
                self.create(
                    name: row[0],
                    val1: row[1],
                    val2: row[2],
                    val3: row[3],
                    val4: row[4],
                    val5: row[5],
                    val6: row[6]
                    )
            end
    end

    def self.headers
       @@headers.slice(0,deck.column_count)
    end

    def self.deck
        @@deck
    end
    def deck
        @@deck
    end

    def self.table_headers
        ["Name", "1. #{headers[1]}", "2. #{headers[2]}", "3. #{headers[3]}", "4. #{headers[4]}", "5. #{headers[5]}", "6. #{headers[6]}"].slice(0,deck.column_count)
    end

    def card_values
        [self.name, self.val1, self.val2, self.val3, self.val4, self.val5, self.val6].slice(0,deck.column_count)
    end



    

    
end

