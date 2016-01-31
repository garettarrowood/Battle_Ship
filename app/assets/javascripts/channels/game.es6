App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    return this.printMessage("Waiting for opponent...");
  },
  printMessage: function(message) {
    return $('#text-area').empty().append("<p>" + message + "</p>");
  },
  disconnected: function() {
    return this.printMessage("Opponent forfeited. You win!")
  },
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    switch (data.action) {
      case "game_ready":
        return this.printMessage("Game started. Make a move!");
      // App.board stuff - must be another js file
      // when "make_move"
      // save the move to server and render move on opponent's screen
    }
  }
});

