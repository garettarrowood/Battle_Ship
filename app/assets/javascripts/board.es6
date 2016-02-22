class Board {
  constructor(ships) {
    this.ships = ships;
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

    if (positions.length !== 0) {
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
      if (ship.classification === anchoredShip.classification) {
        return;
      }
      positions.push(anchoredShip.cells());
    });

    if (positions.length !== 0) {
      return positions.reduce((a, b) => {
        return a.concat(b);
      });
    } else {
      return [];
    }
  }
}
