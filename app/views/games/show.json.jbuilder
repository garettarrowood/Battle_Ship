json.opponent_board do 
  json.patrol_boat do 
    json.left @opponent_board.ships[4].positions[0].point_to_px[0]
    json.top @opponent_board.ships[4].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[4].direction
  end
  json.destroyer do
    json.left @opponent_board.ships[3].positions[0].point_to_px[0]
    json.top @opponent_board.ships[3].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[3].direction
  end
  json.submarine do 
    json.left @opponent_board.ships[2].positions[0].point_to_px[0]
    json.top @opponent_board.ships[2].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[2].direction
  end
  json.battleship do
    json.left @opponent_board.ships[1].positions[0].point_to_px[0]
    json.top @opponent_board.ships[1].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[1].direction
  end
  json.aircraft_carrier do 
    json.left @opponent_board.ships[0].positions[0].point_to_px[0]
    json.top @opponent_board.ships[0].positions[0].point_to_px[1]
    json.direction @opponent_board.ships[0].direction
  end
  json.occupied_positions @opponent_board.occupied_positions_as_strings
end

json.user_board do 
  json.patrol_boat do 
    json.left @user_board.ships[0].positions[0].point_to_px[0]
    json.top @user_board.ships[0].positions[0].point_to_px[1]
    json.direction @user_board.ships[0].direction
  end
  json.destroyer do
    json.left @user_board.ships[1].positions[0].point_to_px[0]
    json.top @user_board.ships[1].positions[0].point_to_px[1]
    json.direction @user_board.ships[1].direction
  end
  json.submarine do 
    json.left @user_board.ships[2].positions[0].point_to_px[0]
    json.top @user_board.ships[2].positions[0].point_to_px[1]
    json.direction @user_board.ships[2].direction
  end
  json.battleship do
    json.left @user_board.ships[3].positions[0].point_to_px[0]
    json.top @user_board.ships[3].positions[0].point_to_px[1]
    json.direction @user_board.ships[3].direction
  end
  json.aircraft_carrier do 
    json.left @user_board.ships[4].positions[0].point_to_px[0]
    json.top @user_board.ships[4].positions[0].point_to_px[1]
    json.direction @user_board.ships[4].direction
  end
  json.occupied_positions @user_board.occupied_positions_as_strings
end
