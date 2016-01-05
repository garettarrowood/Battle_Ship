class Ship {

  constructor(length, classification) {
    this.length = length;
    this.classification = classification;
    if (Ship.all === undefined) {
      Ship.all = [this];
    } else {
      Ship.all.push(this);
    }
  }

  cells() {
    let ship = $('#'+this.classification);
    let row = parseInt(ship[0].style.left)/32 + 13;
    let column = parseInt(ship[0].style.top)/32 + 4;
    let answer = [];

    if (ship.hasClass("vertical")){
      for(let i=0;i<this.length;i++){
        answer.push(column+'-'+row);
        column++;
      }
    } else {
      for(let i=0;i<this.length;i++){
        answer.push(column+'-'+row);
        row++;
      }
    }
    return answer;
  }

  on_board() {
    let ship = document.getElementById(this.classification);
    return ship.style.left !== "" && ship.style.left !== "0px";
  }

}

class Board {

  constructor() {
    this.ships = [new Ship(2, "patrol-boat"), new Ship(3, "destroyer"), new Ship(3, "submarine"), new Ship(4, "battleship"), new Ship(5, "aircraft-carrier")];
  }

  placed_ships() {
    let affirmatives = [];
    this.ships.forEach(ship => {
      if (ship.on_board()) {
        affirmatives.push(ship);
      }
    });
    return affirmatives;
  }

  occupiedPositions(){
    let positions = [];
    this.placed_ships().forEach(ship => {
      positions.push(ship.cells());
    });

    if (positions.length != 0) {
      return positions.reduce((a, b) => {
        return a.concat(b);
      });
    } else {
      return [];
    }
  }

  blockedPositions(ship){
    let positions = [];
    this.placed_ships().forEach(anchoredShip => {
      if (ship.classification == anchoredShip.classification) {
        return;
      }
      positions.push(anchoredShip.cells());
    });

    if (positions.length != 0) {
      return positions.reduce((a, b) => {
        return a.concat(b);
      });
    } else {
      return [];
    }
  }
}

function generateObstacles(ship, board){
  let obstacleArray = [];
  board.blockedPositions(ship).forEach(id => {
    obstacleArray.push({ obstacle: "#"+id, preventCollision: true })
  });
  return obstacleArray;
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

function checkOtherShips(ship, board){
  let answer = true;
  Ship.all.forEach(boat => {
    if (boat.classification === ship.id) {
      let flipped = [],
          first = boat.cells()[0],
          size = boat.cells().length,
          column = parseInt(first),
          row = parseInt(first.substr(2));

      if (ship.className.match(/\bhorizontal\b/)) {
        for(let i=0; i<size; i++) {
          flipped.push((column+i)+'-'+row);
        }
      } else {
        for(let i=0; i<size; i++) {
          flipped.push(column+'-'+(row+1));
        }
      }

      flipped.forEach(position => {
        if (board.blockedPositions(boat).includes(position)) {
          answer = false;
        }
      });
    }
  });
  return answer;
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
      $aircraft_carrier = $('#aircraft-carrier'),
      board = new Board,
      obstacles;

  $('.ship').mousedown(function(){
    if (checkBottomWallCollision(this) && checkRightWallCollision(this) && checkOtherShips(this, board)){
      rotate($(this));
    }
  });

  $patrol_boat.draggable({
    grid: [32,32],
    start: (event, ui) => {
      let patroller = board.ships[0];
      obstacles = generateObstacles(patroller, board);
      $patrol_boat.draggable("option", "multipleCollisionInteractions", obstacles);
      $patrol_boat.draggable("option", "revert", "invalid");
    }
  });

  $destroyer.draggable({
    grid: [32,32],
    start: (event, ui) => {
      let destroyer = board.ships[1];
      obstacles = generateObstacles(destroyer, board);
      $destroyer.draggable("option", "multipleCollisionInteractions", obstacles);
      $destroyer.draggable("option", "revert", "invalid");
    }
  });

  $submarine.draggable({
    grid: [ 32,32 ],
    start: (event, ui) => {
      let submarine = board.ships[2];
      obstacles = generateObstacles(submarine, board);
      $submarine.draggable("option", "multipleCollisionInteractions", obstacles);
      $submarine.draggable("option", "revert", "invalid");
    }
  });

  $battleship.draggable({
    grid: [ 32,32 ],
    start: (event, ui) => {
      let battler = board.ships[3];
      obstacles = generateObstacles(battler, board);
      $battleship.draggable("option", "multipleCollisionInteractions", obstacles);
      $battleship.draggable("option", "revert", "invalid");
    }
  });
  
  $aircraft_carrier.draggable({
    grid: [ 32,32 ],
    start: (event, ui) => {
      let crafter = board.ships[4];
      obstacles = generateObstacles(crafter, board);
      $aircraft_carrier.draggable("option", "multipleCollisionInteractions", obstacles);
      $aircraft_carrier.draggable("option", "revert", "invalid");
    }
  });

  $('#board-setup').droppable({
    accept: ".ship",
    tolerance: "fit"
  });

});

$(document).ready(boardReady);
