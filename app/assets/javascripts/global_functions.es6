// boardReady functions
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

// gamePlay functions

function setUserBoard(boardInfo) {
  let $patrol_boat = $('#patrol-boat'),
      $destroyer = $('#destroyer'),
      $submarine = $('#submarine'),
      $battleship = $('#battleship'),
      $aircraft_carrier = $('#aircraft-carrier');

  if (boardInfo.patrol_boat.direction === "horizontal") {
    $patrol_boat.css("left", boardInfo.patrol_boat.left).css("top", boardInfo.patrol_boat.top);
  } else {
    $patrol_boat.css("left", boardInfo.patrol_boat.left).css("top", boardInfo.patrol_boat.top).removeClass("horizontal").addClass("vertical");
  }

  if (boardInfo.destroyer.direction === "horizontal") {
    $destroyer.css("left", boardInfo.destroyer.left).css("top", boardInfo.destroyer.top);
  } else {
    $destroyer.css("left", boardInfo.destroyer.left).css("top", boardInfo.destroyer.top).removeClass("horizontal").addClass("vertical");
  }

  if (boardInfo.submarine.direction === "horizontal") {
    $submarine.css("left", boardInfo.submarine.left).css("top", boardInfo.submarine.top);
  } else {
    $submarine.css("left", boardInfo.submarine.left).css("top", boardInfo.submarine.top).removeClass("horizontal").addClass("vertical");
  }

  if (boardInfo.battleship.direction === "horizontal") {
    $battleship.css("left", boardInfo.battleship.left).css("top", boardInfo.battleship.top);
  } else {
    $battleship.css("left", boardInfo.battleship.left).css("top", boardInfo.battleship.top).removeClass("horizontal").addClass("vertical");
  }

  if (boardInfo.aircraft_carrier.direction === "horizontal") {
    $aircraft_carrier.css("left", boardInfo.aircraft_carrier.left).css("top", boardInfo.aircraft_carrier.top);
  } else {
    $aircraft_carrier.css("left", boardInfo.aircraft_carrier.left).css("top", boardInfo.aircraft_carrier.top).removeClass("horizontal").addClass("vertical");
  }
}

