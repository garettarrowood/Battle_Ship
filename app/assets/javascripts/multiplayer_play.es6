let multiplayerPlay = (function(){
  App.game.perform("follow", { game_id: gon.game.id })

  setUserBoard(gon.user_board);

  if (gon.game.status == "ongoing") {
    return App.game.printMessage("Opponent has arrived")
  }

  // if last move was opponent's, then enable click
  // $('#opponent-board .cell').on("click", clickCellCallback);

  // access channel with App.game obj

});
