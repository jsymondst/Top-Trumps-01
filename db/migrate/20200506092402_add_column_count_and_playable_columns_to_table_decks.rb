class AddColumnCountAndPlayableColumnsToTableDecks < ActiveRecord::Migration[5.0]
  def change
    add_column(:decks, :column_count, :integer)
    add_column(:decks, :playable_columns, :integer)
  end
end