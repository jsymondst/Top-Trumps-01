# require 'csv'
# require 'pry'
class Card < ActiveRecord::Base

    def self.import_deck(filename)
        #use filename later
        # csv_text = File.read(filename)

        # Card.destroy_all

        csv_text = File.read('./decks/Top Trumps - the Simpsons.csv')
    
        csv_table = csv_text.split("\r\n")

        #set_headers
        header_row = csv_table[0].split(",")
            # @@header0 = header_row[0] 
            @@header1 = header_row[1]
            @@header2 = header_row[2]
            @@header3 = header_row[3]
            @@header4 = header_row[4]
            @@header5 = header_row[5]
            @@header6 = header_row[6]
            
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
        # ["Name", "1. #{@@header1}", "2. #{@@header2}", "3. #{@@header3}", "4. #{@@header4}", "5. #{@@header5}", "6. #{@@header6}"]
        ["Name", @@header1, @@header2, @@header3, @@header4, @@header5, @@header6 ]
    end

    
end

