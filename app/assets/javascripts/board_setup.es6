
class Ship {
  constructor(length, classification) {
    this.length = length;
    this.classification = classification;
  }
}

function rotate($ship) {
  if ($ship.hasClass('horizontal')) {
    $ship.removeClass('horizontal');
    $ship.addClass('vertical');
  } else {
    $ship.removeClass('vertical');
    $ship.addClass('horizontal');
  }
}

function checkBottomWallCollision(ship) {
  switch (ship.id) {
    case "patrol-boat":
      return parseInt(ship.style.top) <= 160;
      break;
    case "destroyer":
    case "submarine":
      return parseInt(ship.style.top) <= 128;
      break;
    case "battleship":
      return parseInt(ship.style.top) <= 96;
      break;
    case "aircraft-carrier":
      return parseInt(ship.style.top) <= 64;
  }
}

function checkRightWallCollision(ship) {
  switch (ship.id) {
    case "patrol-boat":
      return parseInt(ship.style.left) <= -128;
      break;
    case "destroyer":
    case "submarine":
      return parseInt(ship.style.left) <= -160;
      break;
    case "battleship":
      return parseInt(ship.style.left) <= -192;
      break;
    case "aircraft-carrier":
      return parseInt(ship.style.left) <= -224;
  }
}

let boardReady = (function(){
  let $patrol_boat = $('#patrol-boat'),
      $destroyer = $('#destroyer'),
      $submarine = $('#submarine'),
      $battleship = $('#battleship'),
      $aircraft_carrier = $('#aircraft-carrier');

  $('.ship').mousedown(function(){
    if (checkBottomWallCollision(this) && checkRightWallCollision(this)){
      rotate($(this));
    }
  });

  $patrol_boat.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true }, 
                                      { obstacle: "#submarine", preventCollision: true },
                                      { obstacle: "#battleship", preventCollision: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true } ],
    revert: "invalid"
  });

  $destroyer.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#patrol-boat", preventCollision: true }, 
                                      { obstacle: "#submarine", preventCollision: true },
                                      { obstacle: "#battleship", preventCollision: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true } ],
    revert: "invalid"
  });

  $submarine.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true }, 
                                      { obstacle: "#patrol-boat", preventCollision: true },
                                      { obstacle: "#battleship", preventCollision: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true } ],
    revert: "invalid"
  });

  $battleship.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true }, 
                                      { obstacle: "#submarine", preventCollision: true },
                                      { obstacle: "#patrol-boat", preventCollision: true },
                                      { obstacle: "#aircraft-carrier", preventCollision: true } ],
    revert: "invalid"
  });
  
  $aircraft_carrier.draggable({
    grid: [ 32,32 ],
    multipleCollisionInteractions:  [ { obstacle: "#destroyer", preventCollision: true }, 
                                      { obstacle: "#submarine", preventCollision: true },
                                      { obstacle: "#battleship", preventCollision: true },
                                      { obstacle: "#patrol-boat", preventCollision: true } ],
    revert: "invalid"
  });

  $('#board-setup').droppable({
    accept: ".ship",
    tolerance: "fit"
  });

});

$(document).ready(boardReady);
