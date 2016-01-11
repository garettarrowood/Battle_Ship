json.opponent_board do 
  json.patrol_boat do 
    json.starting_point @opponent_board.ships[4].positions[0].point_to_string
    json.direction @opponent_board.ships[4].direction
  end
  json.destroyer do
    json.starting_point @opponent_board.ships[3].positions[0].point_to_string
    json.direction @opponent_board.ships[3].direction
  end
  json.submarine do 
    json.starting_point @opponent_board.ships[2].positions[0].point_to_string
    json.direction @opponent_board.ships[2].direction
  end
  json.battleship do
    json.starting_point @opponent_board.ships[1].positions[0].point_to_string
    json.direction @opponent_board.ships[1].direction
  end
  json.aircraft_carrier do 
    json.starting_point @opponent_board.ships[0].positions[0].point_to_string
    json.direction @opponent_board.ships[0].direction
  end
  json.occupied_positions @opponent_board.occupied_positions_as_strings
  json.moves @opponent_board.moves
end

json.user_board do 
  json.patrol_boat do 
    json.starting_point @user_board.ships[0].positions[0].point_to_string
    json.direction @user_board.ships[0].direction
  end
  json.destroyer do
    json.starting_point @user_board.ships[1].positions[0].point_to_string
    json.direction @user_board.ships[1].direction
  end
  json.submarine do 
    json.starting_point @user_board.ships[2].positions[0].point_to_string
    json.direction @user_board.ships[2].direction
  end
  json.battleship do
    json.starting_point @user_board.ships[3].positions[0].point_to_string
    json.direction @user_board.ships[3].direction
  end
  json.aircraft_carrier do 
    json.starting_point @user_board.ships[4].positions[0].point_to_string
    json.direction @user_board.ships[4].direction
  end
  json.occupied_positions @user_board.occupied_positions_as_strings
  json.moves @user_board.moves
end
