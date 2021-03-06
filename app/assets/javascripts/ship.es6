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
    if (this.on_board()) {
      let ship = $('#'+this.classification),
          row = parseInt(ship[0].style.left)/32 + 13,
          column = parseInt(ship[0].style.top)/32 + 3,
          answer = [];

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
      this.positions = answer;
      return answer;
    }
  }

  on_board() {
    let ship = $('#'+this.classification)[0];
    return ship.style.left !== "" && ship.style.left !== "0px";
  }
}
