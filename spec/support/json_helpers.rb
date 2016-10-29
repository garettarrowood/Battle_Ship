module JsonHelpers
  def ships_json
    {"0" => 
      { "length"=>"2",
        "classification"=>"patrol-boat",
        "positions"=> ["3-5", "3-6"]
      },
    "1" => 
      { "length"=>"3",
        "classification"=>"destroyer",
        "positions"=>[ "4-5", "4-6", "4-7"]
      },
    "2" => 
      { "length"=>"3", 
        "classification"=>"submarine", 
        "positions"=> ["6-4", "6-5", "6-6"]
      },
    "3" => 
      { "length"=>"4",
        "classification"=>"battleship",
        "positions"=> ["8-6", "8-7", "8-8", "8-9"]
      },
    "4" => 
      { "length"=>"5",
        "classification"=>"aircraft-carrier",
        "positions"=> ["10-4", "10-5", "10-6", "10-7", "10-8"]
      }
    }
  end
end

RSpec.configure do |config|
  config.include JsonHelpers
end
