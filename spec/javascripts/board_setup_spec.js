//= require spec_helper
//= require board_setup

describe("Ship#new", function() {

  // beforeEach(function() {
  //   boardReady();
  // });

  // afterEach(function() {
  //   $('#konacha #board-setup').remove();
  // })

  it("can create a new instance", function() {
    var ship = new Ship(2, "patrol_boat");
    expect(ship).to.be.valid;
  });

});



