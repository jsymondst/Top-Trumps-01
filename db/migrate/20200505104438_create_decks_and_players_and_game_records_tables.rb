class CreateDecksAndPlayersAndGameRecordsTables < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.string :deck_path
    end

    create_table :players do |t|
      t.string :name
    end

    create_table :game_records do |t|
      t.integer :player_id
      t.integer :deck_id
      t.integer :win
      t.integer :loss
    end

  end
end
