let sound = true;

let multiplayerPlay = (function(){
  setUserBoard(gon.user_board);
  $(window).unload(disconnectCallBack);

  $('.sound').on('click', function() {
    if ($(this).hasClass('sound-on')) {
      sound = false;
      $(this).removeClass('sound-on').addClass('sound-off');
    } else {
      sound = true;
      $(this).removeClass('sound-off').addClass('sound-on');
    }
  });
});
