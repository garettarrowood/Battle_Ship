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
        this.goFirst(data);
        break;
      case "move success":
        this.moveSuccess(data);
        break;
      case "make move":
        this.makeMove(data);
        break;
      case "game over":
        this.gameOver(data);
        break;
      case "opponent disconnect":
        this.opponentDisconnect(data);
        break;
      case "forfeit":
        window.location.href = `/disconnected`
        break;
    }
  },

  goFirst: function(data) {
    $('#opponent-board .cell').on("click", multiplayerCellCheck);
    this.addOpponentName(data.name);
    this.printMessage("Game started. You go first!", "green");
  },

  moveSuccess: function(data) {
    let $opponent_cell = $("#opponent-"+data.coord);
    if (data.move_success) {
      multiplayerHitCallback($opponent_cell);
    } else {
      multiplayerMissCallback($opponent_cell);
    }
    updateOpponentShipDisplay(data.opponentSunkShips);
    updateUserShipDisplay(data.userSunkShips);
    $opponent_cell.removeClass('available');
  },

  makeMove: function(data) {
    updateMultiplayerUserBoard(data.x, data.y);
    $('#opponent-board .cell').on("click", multiplayerCellCheck);
    this.addOpponentName(data.name);
    this.printMessage("Your turn! Launch a missile.", "green");
  },

  gameOver: function(data) {
    if (data.winner === true) {
      $.ajax({
        url: `/games/${data.gameId}/apply_win`,
        type: 'PUT'
      });
    } else if (data.winner === false) {
      $.ajax({
        url: `/games/${data.gameId}/apply_loss`,
        type: 'PUT'
      });
    }
  },

  opponentDisconnect: function(data) {
    function delayForfeit() {
      window.location.href = `/multiplayer/${data.gameId}/opponent-forfeit`;
    }
    setTimeout(delayForfeit, 1500);
  }
});
