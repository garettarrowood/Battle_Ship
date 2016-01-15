json.opponent_board do 
  json.patrol_boat do 
    json.left @opponent_board.ships[4].positions[0].point_to_px[0]
    json.top @opponent_board.ships[4].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[4].direction
    json.positions @opponent_board.ships[4].positions_to_strings
  end
  json.destroyer do
    json.left @opponent_board.ships[3].positions[0].point_to_px[0]
    json.top @opponent_board.ships[3].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[3].direction
    json.positions @opponent_board.ships[3].positions_to_strings
  end
  json.submarine do 
    json.left @opponent_board.ships[2].positions[0].point_to_px[0]
    json.top @opponent_board.ships[2].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[2].direction
    json.positions @opponent_board.ships[2].positions_to_strings
  end
  json.battleship do
    json.left @opponent_board.ships[1].positions[0].point_to_px[0]
    json.top @opponent_board.ships[1].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[1].direction
    json.positions @opponent_board.ships[1].positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @opponent_board.ships[0].positions[0].point_to_px[0]
    json.top @opponent_board.ships[0].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[0].direction
    json.positions @opponent_board.ships[0].positions_to_strings
  end
  json.occupied_positions @opponent_board.occupied_positions_as_strings
  json.moves @opponent_board.moves
end

json.user_board do 
  json.patrol_boat do 
    json.left @user_board.ships[0].positions[0].point_to_px[0]
    json.top @user_board.ships[0].positions[0].point_to_px[1]
    json.direction @user_board.ships[0].direction
    json.positions @user_board.ships[0].positions_to_strings
  end
  json.destroyer do
    json.left @user_board.ships[1].positions[0].point_to_px[0]
    json.top @user_board.ships[1].positions[0].point_to_px[1]
    json.direction @user_board.ships[1].direction
    json.positions @user_board.ships[1].positions_to_strings
  end
  json.submarine do 
    json.left @user_board.ships[2].positions[0].point_to_px[0]
    json.top @user_board.ships[2].positions[0].point_to_px[1]
    json.direction @user_board.ships[2].direction
    json.positions @user_board.ships[2].positions_to_strings
  end
  json.battleship do
    json.left @user_board.ships[3].positions[0].point_to_px[0]
    json.top @user_board.ships[3].positions[0].point_to_px[1]
    json.direction @user_board.ships[3].direction
    json.positions @user_board.ships[3].positions_to_strings
  end
  json.aircraft_carrier do 
    json.left @user_board.ships[4].positions[0].point_to_px[0]
    json.top @user_board.ships[4].positions[0].point_to_px[1]
    json.direction @user_board.ships[4].direction
    json.positions @user_board.ships[4].positions_to_strings
  end
  json.occupied_positions @user_board.occupied_positions_as_strings
  json.moves @user_board.moves
end