let gamePlay = (function(){

  setUserBoard(gon.user_board);

  if (gon.user_board.moves.length !== 0) {
    setupMoves(gon.user_board.moves, gon.opponent_board.moves); 
    setupSunkShips(gon.user_board.sunkShips, gon.opponent_board.sunkShips);
  }

  $('#opponent-board .cell').on("click", clickCellCallback);
});
