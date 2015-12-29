//= require spec_helper
//= require board_setup

describe("Ship#new", function() {

  beforeEach(function() {
    $('<div class="col-1 first" id="board-setup">\
      <div class="cell" id="[1,1]"></div>\
      <div class="cell" id="[1,2]"></div>\
      <div class="cell" id="[1,3]"></div>\
      <div class="cell" id="[1,4]"></div>\
      <div class="cell" id="[1,5]"></div>\
      <div class="cell" id="[1,6]"></div>\
      <div class="cell" id="[1,7]"></div>\
      <div class="cell" id="[1,8]"></div>\
      <div class="cell" id="[1,9]"></div>\
      <div class="cell" id="[1,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[2,1]"></div>\
      <div class="cell" id="[2,2]"></div>\
      <div class="cell" id="[2,3]"></div>\
      <div class="cell" id="[2,4]"></div>\
      <div class="cell" id="[2,5]"></div>\
      <div class="cell" id="[2,6]"></div>\
      <div class="cell" id="[2,7]"></div>\
      <div class="cell" id="[2,8]"></div>\
      <div class="cell" id="[2,9]"></div>\
      <div class="cell" id="[2,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[3,1]"></div>\
      <div class="cell" id="[3,2]"></div>\
      <div class="cell" id="[3,3]"></div>\
      <div class="cell" id="[3,4]"></div>\
      <div class="cell" id="[3,5]"></div>\
      <div class="cell" id="[3,6]"></div>\
      <div class="cell" id="[3,7]"></div>\
      <div class="cell" id="[3,8]"></div>\
      <div class="cell" id="[3,9]"></div>\
      <div class="cell" id="[3,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[4,1]"></div>\
      <div class="cell" id="[4,2]"></div>\
      <div class="cell" id="[4,3]"></div>\
      <div class="cell" id="[4,4]"></div>\
      <div class="cell" id="[4,5]"></div>\
      <div class="cell" id="[4,6]"></div>\
      <div class="cell" id="[4,7]"></div>\
      <div class="cell" id="[4,8]"></div>\
      <div class="cell" id="[4,9]"></div>\
      <div class="cell" id="[4,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[5,1]"></div>\
      <div class="cell" id="[5,2]"></div>\
      <div class="cell" id="[5,3]"></div>\
      <div class="cell" id="[5,4]"></div>\
      <div class="cell" id="[5,5]"></div>\
      <div class="cell" id="[5,6]"></div>\
      <div class="cell" id="[5,7]"></div>\
      <div class="cell" id="[5,8]"></div>\
      <div class="cell" id="[5,9]"></div>\
      <div class="cell" id="[5,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[6,1]"></div>\
      <div class="cell" id="[6,2]"></div>\
      <div class="cell" id="[6,3]"></div>\
      <div class="cell" id="[6,4]"></div>\
      <div class="cell" id="[6,5]"></div>\
      <div class="cell" id="[6,6]"></div>\
      <div class="cell" id="[6,7]"></div>\
      <div class="cell" id="[6,8]"></div>\
      <div class="cell" id="[6,9]"></div>\
      <div class="cell" id="[6,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[7,1]"></div>\
      <div class="cell" id="[7,2]"></div>\
      <div class="cell" id="[7,3]"></div>\
      <div class="cell" id="[7,4]"></div>\
      <div class="cell" id="[7,5]"></div>\
      <div class="cell" id="[7,6]"></div>\
      <div class="cell" id="[7,7]"></div>\
      <div class="cell" id="[7,8]"></div>\
      <div class="cell" id="[7,9]"></div>\
      <div class="cell" id="[7,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[8,1]"></div>\
      <div class="cell" id="[8,2]"></div>\
      <div class="cell" id="[8,3]"></div>\
      <div class="cell" id="[8,4]"></div>\
      <div class="cell" id="[8,5]"></div>\
      <div class="cell" id="[8,6]"></div>\
      <div class="cell" id="[8,7]"></div>\
      <div class="cell" id="[8,8]"></div>\
      <div class="cell" id="[8,9]"></div>\
      <div class="cell" id="[8,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[9,1]"></div>\
      <div class="cell" id="[9,2]"></div>\
      <div class="cell" id="[9,3]"></div>\
      <div class="cell" id="[9,4]"></div>\
      <div class="cell" id="[9,5]"></div>\
      <div class="cell" id="[9,6]"></div> \
      <div class="cell" id="[9,7]"></div>\
      <div class="cell" id="[9,8]"></div>\
      <div class="cell" id="[9,9]"></div>\
      <div class="cell" id="[9,10]"></div>\
      <div id="new-row"></div>\
      <div class="cell" id="[10,1]"></div>\
      <div class="cell" id="[10,2]"></div>\
      <div class="cell" id="[10,3]"></div>\
      <div class="cell" id="[10,4]"></div>\
      <div class="cell" id="[10,5]"></div>\
      <div class="cell" id="[10,6]"></div>\
      <div class="cell" id="[10,7]"></div>\
      <div class="cell" id="[10,8]"></div>\
      <div class="cell" id="[10,9]"></div>\
      <div class="cell" id="[10,10]"></div>\
    </div>').appendTo('#konacha');
    boardReady();
  });

  afterEach(function() {
    $('#konacha #board-setup').remove();
  })

  it("can create a new instance", function() {
    var ship = new Ship(2, "patrol_boat");
    expect(ship).to.be.valid;
  });

});



