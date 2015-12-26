function boardSetup(){

  class Ship {
    constructor(length, classification) {
      this.length = length;
      this.classification = classification;
    }
  }

  var foo = "bar";

  $('div#board-setup').click(function() {
    $('.cell').hide();
  });

}

$(document).ready(boardSetup);
