let gamePlay = (function(){
  let gamePath =  window.location.pathname
  let gameId = gamePath.substr(gamePath.lastIndexOf('/') + 1);
// make call to server to retrieve game state
  $.get(`/games/${gameId}`, function(data) {
    let boardInfo = data;
    debugger
  });

// position user ships over user board - add divs with correct ids (z-index: 1)? Get 1st and 2nd position and classification from server.

// Scan all moves contained on each board. Do I recalculate if each move to see if it hits a ship then apply appropriate class (again)?

// When user clicks a div.cell on opponent's board, see if it shits ship, then change class accordingly. Send info back to server to add move to board. Backend then calculates opponent's move and sends it back to this view. OR do I have to write the AI in JS?

});
