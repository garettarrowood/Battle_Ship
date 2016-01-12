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

  $('#board-complete').on("click", (event) => {
    let valid = true;
    board.ships.forEach(ship => {
      ship.cells();
      if (!ship.on_board()) {
        valid = false;
      }
    });

    if (valid) {
      $.post("/games", { ships: board.ships } )
    } else {
      alert("Make sure all your ships are placed before submitting your board.");
    }
  });
});
