App.game = App.cable.subscriptions.create("GameChannel", {

  connected: function() {
    this.printMessage("Waiting for game to start...", "red");
  },

  printMessage: function(message, color) {
    $('#multiplayer-message').empty().append("<p class='" + color + "''>" + message + "</p>");
  },

  disconnected: function() {
  },

  received: function(data) {
    switch (data.action) {
      case "go first":
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.printMessage("Game started. You go first!", "green");
        break;
      case "move success":
        let $opponent_cell = $("#opponent-"+data.coord);
        if (data.move_success) {
          $opponent_cell.addClass("hit");
          this.printMessage("Hit! Wait for opponent's move.", "red");
        } else {
          $opponent_cell.addClass("miss");
          this.printMessage("Miss. Wait for opponent's move.", "red");
        }
        updateOpponentShipDisplay(data.opponentSunkShips);
        updateUserShipDisplay(data.userSunkShips);
        $opponent_cell.removeClass('available');
        break;
      case "make move":
        updateUserBoard(data.x, data.y);
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.printMessage("Your turn! Launch a missile.", "green");
        break;
      case "game over":
        if (data.winner === true) {
          window.location.href = `/games/${data.gameId}/won`;
        } else if (data.winner === false) {
          window.location.href = `/games/${data.gameId}/lost`;
        }
        break;
      case "gave up":
        function delayForfeit() {
          window.location.href = `/multiplayer/${data.gameId}/opponent-forfeit`;
        }
        setTimeout(delayForfeit, 2500);
        break;
    }
  }
});
