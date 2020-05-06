Deck.destroy_all
GameRecord.destroy_all
Player.destroy_all

Deck.create(name:"The Simpsons", deck_path:"./decks/Top Trumps - the Simpsons.csv", column_count: 7, playable_columns: 6)
Deck.create(name:"Harry Potter", deck_path:"./decks/Top Trumps - Harry Potter.csv", column_count: 6, playable_columns: 5)
Deck.create(name:"Star Wars Starships", deck_path:"./decks/Top Trumps - Star Wars Starships.csv", column_count: 7, playable_columns: 5)
