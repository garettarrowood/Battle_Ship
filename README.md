# BattleShip

Full-stack battleship game

One can play against the computer or online against a live opponent.

Uses Rails 5's Actionable for web socket connections.
ES6 and jQuery to manipulate the DOM.

## Running Locally

To run this locally and use websockets, you have to install redis:

```
brew install redis
```

Then in addition to launching a `rails server` you must also launch redis:
```
redis-server
```

## Tests

Run the test suite with the `rspec` command.
You must launch a `redis-server` for the Actioncable related tests to pass.
