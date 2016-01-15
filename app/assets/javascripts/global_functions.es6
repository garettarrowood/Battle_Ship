// boardReady functions
function generateObstacles(ship, board) {
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

function checkOtherShips(ship, board) {
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

  setUserShip(boardInfo.patrol_boat, $patrol_boat);
  setUserShip(boardInfo.destroyer, $destroyer);
  setUserShip(boardInfo.submarine, $submarine);
  setUserShip(boardInfo.battleship, $battleship);
  setUserShip(boardInfo.aircraft_carrier, $aircraft_carrier);
}

function setUserShip(boatData, $boat) {
  if (boatData.direction === "horizontal") {
    $boat.css("left", boatData.left).css("top", boatData.top);
  } else {
    $boat.css("left", boatData.left).css("top", boatData.top).removeClass("horizontal").addClass("vertical");
  }
}

// wait for sound to finish before going on? - setTimeout()
function clickCellCallback() {
  if ($(this).hasClass("available")) {
    let launch = new Audio('/assets/Missle_Launch.mp3'),
        gamePath =  window.location.pathname,
        gameId = gamePath.substr(gamePath.lastIndexOf('/') + 1),
        opponent_coord = this.id.split("opponent-")[1];

    launch.play();
    updateOpponentBoard($(this), opponent_coord);

    $.post(`/games/${gameId}/move`, {move: opponent_coord}).done(function(data) {
      debugger
      updateOpponentShipDisplay(data.opponentSunkShips);
      updateUserBoard(data);
      updateUserShipDisplay(data.userSunkShips);
    });

    $(this).removeClass('available');
  }
};

function updateUserBoard(data) {
  let user_coord = `${data.move.y}-${data.move.x}`;
  if (isUserShipHit(user_coord)) {
    $('#user-'+data.move.y+'-'+data.move.x).addClass("hit");
  } else {
    $('#user-'+data.move.y+'-'+data.move.x).addClass("miss");
  }
}

function updateOpponentBoard(el, opponent_coord) {
  if (isOpponentShipHit(opponent_coord)) {
    el.addClass("hit");
  } else {
    el.addClass("miss");
  }
}

function isUserShipHit(user_coord) {
  return gon.user_board.occupied_positions.includes(user_coord);
}

function isOpponentShipHit(opponent_coord) {
  return gon.opponent_board.occupied_positions.includes(opponent_coord);
}

function updateOpponentShipDisplay(ships) {
  // if ships.length === 5, then redirect to game over
  ships.forEach(ship => {
    debugger
    $("#opponent-block "+`.dummy-${ship.split(" ")[0].toLowerCase()}`).css("display", "inline-block");
  });
}

function updateUserShipDisplay(ships) {
  // if ships.length === 5, then redirect to game over
  ships.forEach(ship => {
    $("#user-block "+`.dummy-${ship.split(" ")[0].toLowerCase()}`).css("display", "inline-block");
  });
}
