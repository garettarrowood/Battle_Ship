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

function validBoardSetup(board) {
  let valid = true;
  board.ships.forEach(ship => {
    ship.cells();
    if (!ship.on_board()) {
      valid = false;
    }
  });
  return valid;
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

function clickCellCallback() {
  if ($(this).hasClass("available")) {
    let path =  window.location.pathname,
        opponent_coord = this.id.split("opponent-")[1],
        opponent_x = opponent_coord.split("-")[1],
        opponent_y = opponent_coord.split("-")[0];

    updateOpponentBoard(opponent_x, opponent_y);

    $.post(`${path}/move`, {move: opponent_coord}).done(gameUpdates);
  }
};

function updateUserBoard(x, y) {
  let user_coord = `${y}-${x}`;
  if (isUserShipHit(user_coord)) {
    $('#user-'+user_coord).addClass("hit");
  } else {
    $('#user-'+user_coord).addClass("miss");
  }
}

function updateOpponentBoard(x, y) {
  let opponent_coord = `${y}-${x}`,
      $opponent_cell = $('#opponent-'+opponent_coord);

  if (isOpponentShipHit(opponent_coord)) {
    $opponent_cell.addClass("hit");
  } else {
    $opponent_cell.addClass("miss");
  }

  $opponent_cell.removeClass('available');
}

function isUserShipHit(user_coord) {
  return gon.user_board.occupied_positions.includes(user_coord);
}

function isOpponentShipHit(opponent_coord) {
  return gon.opponent_board.occupied_positions.includes(opponent_coord);
}

function updateOpponentShipDisplay(ships) {
  ships.forEach(ship => {
    $("#opponent-block "+`.dummy-${ship.split(" ")[0].toLowerCase()}`).css("display", "inline-block");
  });
}

function updateUserShipDisplay(ships) {
  ships.forEach(ship => {
    $("#user-block "+`.dummy-${ship.split(" ")[0].toLowerCase()}`).css("display", "inline-block");
  });
}

function setupMoves(userMoves, opponentMoves) {
  userMoves.forEach(move => {
    updateUserBoard(move.position.x, move.position.y);
  });

  opponentMoves.forEach(move => {
    updateOpponentBoard(move.position.x, move.position.y)
  });
}

function setupSunkShips(sunkUserShips, sunkOpponentShips) {
  updateUserShipDisplay(sunkUserShips);
  updateOpponentShipDisplay(sunkOpponentShips);
}

function gameUpdates(data) {
  let gamePath = window.location.pathname;

  updateOpponentShipDisplay(data.opponentSunkShips);
  updateUserBoard(data.move.x, data.move.y);
  updateUserShipDisplay(data.userSunkShips);

  if (data.userWins === true) {
    window.location.href = `${gamePath}/won`;
  } else if (data.opponentWins === true) {
    window.location.href = `${gamePath}/lost`;
  }
}

// multiplayer functions

function multiplayerCellCheck() {
  if ($(this).hasClass("available")) {
    let path = window.location.pathname,
        gameId = path.split("/")[2],
        opponent_coord = this.id.split("opponent-")[1],
        opponent_x = opponent_coord.split("-")[1],
        opponent_y = opponent_coord.split("-")[0];

    App.game.perform("move", { game_id: gameId, x: opponent_x, y: opponent_y, coord: opponent_coord });

    $('#opponent-board .cell').off("click");
  }
};

function loseCallBack(){
  let path = window.location.pathname,
      gameId = path.split("/")[2];

  App.game.perform("lose", { game_id: gameId} )
}


