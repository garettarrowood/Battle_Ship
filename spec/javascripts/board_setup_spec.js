//= require spec_helper
//= require board_setup


describe("Ship#new", function() {
  boardSetup();

  it("can create a new instance", function() {
    var ship = new Ship(5, "patrol_boat");
    expect(ship).to.be.valid;
  });

  it('foo', function() {
    expect(foo).to.equal('bar');
  });


});

