App.game = App.cable.subscriptions.create("GameChannel", {

  connected: function() {
    this.printMessage("Waiting for game to start...", "red");
  },

  printMessage: function(message, color) {
    $('#multiplayer-message').empty().append("<p class='" + color + "''>" + message + "</p>");
  },

  addOpponentName: function(name) {
    $('.opponent-name').empty().append("playing against " + name);
  },

  received: function(data) {
    switch (data.action) {
      case "go first":
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.addOpponentName(data.name);
        this.printMessage("Game started. You go first!", "green");
        break;
      case "move success":
        let $opponent_cell = $("#opponent-"+data.coord);
        if (data.move_success) {
          multiplayerHitCallback($opponent_cell);
        } else {
          multiplayerMissCallback($opponent_cell);
        }
        updateOpponentShipDisplay(data.opponentSunkShips);
        updateUserShipDisplay(data.userSunkShips);
        $opponent_cell.removeClass('available');
        break;
      case "make move":
        updateMultiplayerUserBoard(data.x, data.y);
        $('#opponent-board .cell').on("click", multiplayerCellCheck);
        this.addOpponentName(data.name);
        this.printMessage("Your turn! Launch a missile.", "green");
        break;
      case "game over":
        if (data.winner === true) {
          window.location.href = `/games/${data.gameId}/won`;
        } else if (data.winner === false) {
          window.location.href = `/games/${data.gameId}/lost`;
        }
        break;
      case "opponent disconnect":
        function delayForfeit() {
          window.location.href = `/multiplayer/${data.gameId}/opponent-forfeit`;
        }
        setTimeout(delayForfeit, 1500);
        break;
      case "forfeit":
        window.location.href = `/disconnected`
        break;
    }
  }
});
