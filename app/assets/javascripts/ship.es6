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
