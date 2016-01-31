App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    return this.printMessage("Waiting for opponent...");
  },
  printMessage: function(message) {
    return $('#multiplayer-message').empty().append("<p>" + message + "</p>");
  },
  disconnected: function() {
    return this.printMessage("Opponent forfeited. You win!")
  },
  received: function(data) {
    switch (data.action) {
      case "go first":
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.printMessage("Game started. You go first!");
        break;
      case "move success":
        let $opponent_cell = $("#opponent-"+data.coord);
        if (data.move_success) {
          $opponent_cell.addClass("hit");
          this.printMessage("Hit! Now wait for your turn.");
        } else {
          $opponent_cell.addClass("miss");
          this.printMessage("Miss. Now wait for your turn.");
        }
        updateOpponentShipDisplay(data.opponentSunkShips);
        updateUserShipDisplay(data.userSunkShips);
        $opponent_cell.removeClass('available');
        break;
      case "make move":
        updateUserBoard(data.x, data.y);
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.printMessage("Your turn! Launch you missile.");
        break;
      case "game over":
        if (data.winner === true) {
          window.location.href = `/games/${data.gameId}/won`;
        } else if (data.winner === false) {
          window.location.href = `/games/${data.gameId}/lost`;
        }
        break;
    }
  }
});
