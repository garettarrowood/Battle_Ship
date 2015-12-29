
class Ship {
  constructor(length, classification) {
    this.length = length;
    this.classification = classification;
  }
}


let boardReady = (function(){
  let $patrol_boat = $('#patrol-boat'),
      $destroyer = $('#destroyer'),
      $submarine = $('#submarine'),
      $battleship = $('#battleship'),
      $aircraft_carrier = $('#aircraft-carrier');

  $('.ship').click(function(){
    if ($(this).hasClass('horizontal')) {
      $(this).removeClass('horizontal');
      $(this).addClass('vertical');
    } else {
      $(this).removeClass('vertical');
      $(this).addClass('horizontal');
    }
  });

  $('.ship').draggable({
    grid: [ 31,31 ]
  });

});

$(document).ready(boardReady);
