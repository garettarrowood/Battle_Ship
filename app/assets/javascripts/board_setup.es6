
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


// the droppable excepts the new dimensions of a directional shift, then do it, otherwise don't
  $('.ship').mousedown(function(){
    if (this.style.left !== "" && this.style.left !== "0px") {
      if ($(this).hasClass('horizontal')) {
        $(this).removeClass('horizontal');
        $(this).addClass('vertical');
      } else {
        $(this).removeClass('vertical');
        $(this).addClass('horizontal');
      }
    } else {
      if ($(this).hasClass('horizontal')) {
        $(this).removeClass('horizontal');
        $(this).addClass('vertical');
      } else {
        $(this).removeClass('vertical');
        $(this).addClass('horizontal');
      }
    }
  });

  $patrol_boat.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true, preventProtrusion: true }, 
                                      { obstacle: "#submarine", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#battleship", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true, preventProtrusion: true } ],
    revert: "invalid"
  });

  $destroyer.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#patrol-boat", preventCollision: true, preventProtrusion: true }, 
                                      { obstacle: "#submarine", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#battleship", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true, preventProtrusion: true } ],
    revert: "invalid"
  });

  $submarine.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true, preventProtrusion: true }, 
                                      { obstacle: "#patrol-boat", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#battleship", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true, preventProtrusion: true } ],
    revert: "invalid"
  });

  $battleship.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true , preventProtrusion: true}, 
                                      { obstacle: "#submarine", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#patrol-boat", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true, preventProtrusion: true } ],
    revert: "invalid"
  });
  
  $aircraft_carrier.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true, preventProtrusion: true }, 
                                      { obstacle: "#submarine", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#battleship", preventCollision: true, preventProtrusion: true },
                                      { obstacle: "#patrol-boat", preventCollision: true, preventProtrusion: true } ],
    revert: "invalid"
  });

  $('#board-setup').droppable({
    accept: ".ship",
    tolerance: "fit"
  });

});

$(document).ready(boardReady);
