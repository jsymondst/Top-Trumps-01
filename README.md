# Top Trumps!

Install instructions:

- Clone the repo
- Install gems with `bundle install`
- Setup the database with `rake db:drop | rake db:setup`
- Run the app with `ruby main.rb`
- (Optional:) run `rake calibrate` to calibrate the display (check if it's wide enough.)

Play Instructions:

- Run the app with `ruby main.rb`
- Create a player if you haven't got one already, then start a game
- Once you've selected a deck, the game will flip a coin to see if you or the computer plays first.
  - On the computer's turn, it will automatically choose a category after a few seconds
  - On your turn, choose a category you think will be better than the opponent's
- Once a category has been chosen, the game will compare the scores on the two cards, and the higher card's player wins that round.
- Whoever wins the round gets a point, and gets to choose next.
- The game continues until one player has won 5 points.

---

The entry point to the app is in main.rb. This takes you (after a splash page) to the main menu.

app/menu.rb contains the menu. Option menus are rendered using TTY, and from there you can start a game (managed in app/game.rb) and view win/loss stats (managed in app/stats.rb)
