//= require board_setup

describe("Array#sum", function() {
  it("returns 0 when the Array is empty", function() {
    [].sum().should.equal(0);
  });

  it("returns the sum of numeric elements", function() {
    [1,2,3].sum().should.equal(6);
  });
});