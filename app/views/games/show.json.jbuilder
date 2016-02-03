json.opponent_board do 
  json.patrol_boat do 
    json.left @opponent_patrol.positions[0].point_to_px[0]
    json.top @opponent_patrol.positions[0].point_to_px[1]
    json.direction @opponent_patrol.direction
    json.positions @opponent_patrol.positions_to_strings
  end
  json.destroyer do
    json.left @opponent_destroyer.positions[0].point_to_px[0]
    json.top @opponent_destroyer.positions[0].point_to_px[1]
    json.direction @opponent_destroyer.direction
    json.positions @opponent_destroyer.positions_to_strings
  end
  json.submarine do 
    json.left @opponent_submarine.positions[0].point_to_px[0]
    json.top @opponent_submarine.positions[0].point_to_px[1]
    json.direction @opponent_submarine.direction
    json.positions @opponent_submarine.positions_to_strings
  end
  json.battleship do
    json.left @opponent_battleship.positions[0].point_to_px[0]
    json.top @opponent_battleship.positions[0].point_to_px[1]
    json.direction @opponent_battleship.direction
    json.positions @opponent_battleship.positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @opponent_carrier.positions[0].point_to_px[0]
    json.top @opponent_carrier.positions[0].point_to_px[1]
    json.direction @opponent_carrier.direction
    json.positions @opponent_carrier.positions_to_strings
  end
  json.occupied_positions @opponent_board.occupied_positions_as_strings
  json.sunkShips @opponent_board.sunk_ships
  json.moves @opponent_board.moves
end

json.user_board do 
  json.patrol_boat do 
    json.left @user_patrol.positions[0].point_to_px[0]
    json.top @user_patrol.positions[0].point_to_px[1]
    json.direction @user_patrol.direction
    json.positions @user_patrol.positions_to_strings
  end
  json.destroyer do
    json.left @user_destroyer.positions[0].point_to_px[0]
    json.top @user_destroyer.positions[0].point_to_px[1]
    json.direction @user_destroyer.direction
    json.positions @user_destroyer.positions_to_strings
  end
  json.submarine do 
    json.left @user_submarine.positions[0].point_to_px[0]
    json.top @user_submarine.positions[0].point_to_px[1]
    json.direction @user_submarine.direction
    json.positions @user_submarine.positions_to_strings
  end
  json.battleship do
    json.left @user_battleship.positions[0].point_to_px[0]
    json.top @user_battleship.positions[0].point_to_px[1]
    json.direction @user_battleship.direction
    json.positions @user_battleship.positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @user_carrier.positions[0].point_to_px[0]
    json.top @user_carrier.positions[0].point_to_px[1]
    json.direction @user_carrier.direction
    json.positions @user_carrier.positions_to_strings
  end
  json.occupied_positions @user_board.occupied_positions_as_strings
  json.moves @user_board.moves
  json.sunkShips @user_board.sunk_ships
end
