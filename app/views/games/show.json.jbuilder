json.opponent_board do 
  json.patrol_boat do 
    json.left @opponent_board.patrol_boat.positions[0].point_to_px[0]
    json.top @opponent_board.patrol_boat.positions[0].point_to_px[1]
    json.direction @opponent_board.patrol_boat.direction
    json.positions @opponent_board.patrol_boat.positions_to_strings
  end
  json.destroyer do
    json.left @opponent_board.destroyer.positions[0].point_to_px[0]
    json.top @opponent_board.destroyer.positions[0].point_to_px[1]
    json.direction @opponent_board.destroyer.direction
    json.positions @opponent_board.destroyer.positions_to_strings
  end
  json.submarine do 
    json.left @opponent_board.submarine.positions[0].point_to_px[0]
    json.top @opponent_board.submarine.positions[0].point_to_px[1]
    json.direction @opponent_board.submarine.direction
    json.positions @opponent_board.submarine.positions_to_strings
  end
  json.battleship do
    json.left @opponent_board.battleship.positions[0].point_to_px[0]
    json.top @opponent_board.battleship.positions[0].point_to_px[1]
    json.direction @opponent_board.battleship.direction
    json.positions @opponent_board.battleship.positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @opponent_board.aircraft_carrier.positions[0].point_to_px[0]
    json.top @opponent_board.aircraft_carrier.positions[0].point_to_px[1]
    json.direction @opponent_board.aircraft_carrier.direction
    json.positions @opponent_board.aircraft_carrier.positions_to_strings
  end
  json.occupied_positions @opponent_board.occupied_positions_as_strings
  json.sunkShips @opponent_board.sunk_ships
  json.moves @opponent_board.moves
end

json.user_board do 
  json.patrol_boat do 
    json.left @user_board.patrol_boat.positions[0].point_to_px[0]
    json.top @user_board.patrol_boat.positions[0].point_to_px[1]
    json.direction @user_board.patrol_boat.direction
    json.positions @user_board.patrol_boat.positions_to_strings
  end
  json.destroyer do
    json.left @user_board.destroyer.positions[0].point_to_px[0]
    json.top @user_board.destroyer.positions[0].point_to_px[1]
    json.direction @user_board.destroyer.direction
    json.positions @user_board.destroyer.positions_to_strings
  end
  json.submarine do 
    json.left @user_board.submarine.positions[0].point_to_px[0]
    json.top @user_board.submarine.positions[0].point_to_px[1]
    json.direction @user_board.submarine.direction
    json.positions @user_board.submarine.positions_to_strings
  end
  json.battleship do
    json.left @user_board.battleship.positions[0].point_to_px[0]
    json.top @user_board.battleship.positions[0].point_to_px[1]
    json.direction @user_board.battleship.direction
    json.positions @user_board.battleship.positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @user_board.aircraft_carrier.positions[0].point_to_px[0]
    json.top @user_board.aircraft_carrier.positions[0].point_to_px[1]
    json.direction @user_board.aircraft_carrier.direction
    json.positions @user_board.aircraft_carrier.positions_to_strings
  end
  json.occupied_positions @user_board.occupied_positions_as_strings
  json.moves @user_board.moves
  json.sunkShips @user_board.sunk_ships
end
