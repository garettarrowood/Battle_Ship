//= require spec_helper
//= require ship
//= require board

describe("Board", function() {
  var board = new Board();

  it("initializes with 5 ships", function() {
    expect(board.ships.length).to.equal(5);
  });

  describe('#placed_ships()', function() {


  });

});