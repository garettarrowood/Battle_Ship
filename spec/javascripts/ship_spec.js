//= require spec_helper
//= require ship

describe("Ship", function() {
  afterEach(function() {
    Ship.all.splice(0, Ship.all.length);
  });

  it("accepts two arguments upon initialization", function() {
    var ship = new Ship(2, "canoe");
    expect(ship).to.be.valid;
  });

  it("keeps a tally of every ship in existence", function() {
    expect(Ship.all.length).to.equal(0);
    new Ship(4, "pirate ship");
    new Ship(6, "long boat");
    expect(Ship.all.length).to.equal(2);
  });

  describe('#cells()', function() {
    beforeEach(function() {
      $('<span id="board-setup">\
          <div class="cell" id="1-1"></div>\
          <div class="cell" id="1-2"></div>\
          <div class="cell" id="1-3"></div>\
          <div class="cell" id="1-4"></div>\
          <div class="cell" id="1-5"></div>\
          <div class="cell" id="1-6"></div>\
          <div class="cell" id="1-7"></div>\
          <div class="cell" id="1-8"></div>\
          <div class="cell" id="1-9"></div>\
          <div class="cell" id="1-10"></div>\
          <div id="new-row"></div>\
          <div class="cell" id="2-1"></div>\
          <div class="cell" id="2-2"></div>\
          <div class="cell" id="2-3"></div>\
          <div class="cell" id="2-4"></div>\
          <div class="cell" id="2-5"></div>\
          <div class="cell" id="2-6"></div>\
          <div class="cell" id="2-7"></div>\
          <div class="cell" id="2-8"></div>\
          <div class="cell" id="2-9"></div>\
          <div class="cell" id="2-10"></div>\
          <div id="new-row"></div>\
        </span>').appendTo('#konacha');
      $('<span class="ship position-a ui-draggable ui-draggable-handle horizontal" id="patrol-boat" style="left: -256px; top: -96px;"></span>').appendTo('#konacha');
    });

    afterEach(function() {
      $('#konacha #board-setup').remove();
      $('#konacha #patrol-boat').remove();
      Ship.all.splice(0, Ship.all.length);
    })

    it("returns an array of positions", function() {
      var patrol_boat = new Ship(2, "patrol-boat");
      expect(patrol_boat.cells()).to.be.an("array");
      expect(patrol_boat.cells())
    });

    it("has number of positions equal to length of ship", function() {
      var long_patrol_boat = new Ship(4, "patrol-boat");
      expect(long_patrol_boat.cells().length).to.equal(long_patrol_boat.length)
    });

    it("those positions match one div.cell id", function() {
      var patrol_boat = new Ship(2, "patrol-boat");
      var position = patrol_boat.cells()[0];
      expect($('#'+position).length).to.equal(1);
    });
  });

  describe('#on_board()', function() {
    beforeEach(function() {
      $('<span id="board-setup">\
          <div class="cell" id="1-1"></div>\
          <div class="cell" id="1-2"></div>\
          <div class="cell" id="1-3"></div>\
          <div class="cell" id="1-4"></div>\
          <div class="cell" id="1-5"></div>\
          <div class="cell" id="1-6"></div>\
          <div class="cell" id="1-7"></div>\
          <div class="cell" id="1-8"></div>\
          <div class="cell" id="1-9"></div>\
          <div class="cell" id="1-10"></div>\
          <div id="new-row"></div>\
          <div class="cell" id="2-1"></div>\
          <div class="cell" id="2-2"></div>\
          <div class="cell" id="2-3"></div>\
          <div class="cell" id="2-4"></div>\
          <div class="cell" id="2-5"></div>\
          <div class="cell" id="2-6"></div>\
          <div class="cell" id="2-7"></div>\
          <div class="cell" id="2-8"></div>\
          <div class="cell" id="2-9"></div>\
          <div class="cell" id="2-10"></div>\
          <div id="new-row"></div>\
        </span>').appendTo('#konacha');
    });

    afterEach(function() {
      $('#konacha #board-setup').remove();
      $('#konacha #patrol-boat').remove();
      Ship.all.splice(0, Ship.all.length);
    })

    it("responds true if ship element has style that positions it on board", function() {
      var patrol_boat = new Ship(2, "patrol-boat");
      $('<span class="ship position-a ui-draggable ui-draggable-handle horizontal" id="patrol-boat" style="left: -256px; top: -96px;"></span>').appendTo('#konacha');
      expect(patrol_boat.on_board()).to.be.true;
    });

    it("responds false if ship has no positions set in style attribute", function() {
      var patrol_boat = new Ship(2, "patrol-boat");
      $('<span class="ship position-a ui-draggable ui-draggable-handle horizontal" id="patrol-boat"></span>').appendTo('#konacha');
      expect(patrol_boat.on_board()).to.be.false;
    });

    it("responds false if ship positioned in its starting position", function() {
      var patrol_boat = new Ship(2, "patrol-boat");
      $('<span class="ship position-a ui-draggable ui-draggable-handle horizontal" id="patrol-boat" style="left: 0px; top: 0px;"></span>').appendTo('#konacha');
      expect(patrol_boat.on_board()).to.be.false;
    });
  });
});
