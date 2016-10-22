# BattleShip

Full-stack battleship game

One can play against a computer AI or against an online opponent.

Uses Rails 5's Actionable for web socket connections.
ES6 and jQuery to manipulate the DOM.

### TODO:

More test coverage.
Add game stat columns to User model and get rid of expensive user_stat queries.
Then delete finished games and affliated boards, ships, and moves and save BIG time on the db.
