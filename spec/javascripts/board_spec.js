//= require spec_helper
//= require ship
//= require board

describe("Board", function() {
  var patrolStub = {
    on_board: function() {
      return true;
    }
  },
      destroyerStub = {
    on_board: function() {
      return true;
    }
  },
      submarineStub = {
    on_board: function() {
      return true;
    }
  },
      battleshipStub = {
    on_board: function() {
      return true;
    }
  },
      aircraftStub  = {
    on_board: function() {
      return true;
    }
  };

  var board = new Board([patrolStub, destroyerStub, submarineStub, battleshipStub, aircraftStub]);

  it("initializes with 5 ships", function() {
    expect(board.ships.length).to.equal(5);
  });

  it('trying to get on_board() to return true on my ships by stubbing, instead of writing out a bunch of fake html to when the method is already tested', function() {
    

  });
});

