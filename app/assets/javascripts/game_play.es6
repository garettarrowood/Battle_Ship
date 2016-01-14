let gamePlay = (function(){

  setUserBoard(gon.user_board);

  // add check for previous moves function is game - important if page gets reloaded - if gon.board.moves === [], then nothing to do, otherwise implement

  $('#opponent-board .cell').on("click", clickCellCallback);
});
