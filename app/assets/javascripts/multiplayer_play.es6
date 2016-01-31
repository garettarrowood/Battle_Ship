let multiplayerPlay = (function(){
  function delayConnection(){
    window.setTimeout(
      App.game.perform("follow", { game_id: gon.game.id }),
       1000);
  }
  delayConnection();

  setUserBoard(gon.user_board);
});
