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