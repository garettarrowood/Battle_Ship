//= require spec_helper
//= require ship
//= require board

describe("Board", function() {
  var board = new Board(),
      patrol = board.ships[0];

  it("initializes with 5 ships", function() {
    expect(board.ships.length).to.equal(5);
  });

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

  it('trying to get on_board() to return true on my ships by stubbing, instead of writing out a bunch of fake html to when the method is already tested', function() {
    
    // rewrite board class to accept 5 ships on initialization - should not be unreasonable
    // write own stubs for those ships - Brandon: "instead of `new Ship(...)` you can pass in a stub constructor like `function(){this.on_board = function(){return true;};}""
    // should't need Sinon at all then, maybe

  });
});

