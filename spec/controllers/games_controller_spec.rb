require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  before(:each) do
    @user = create(:user)
    log_in @user
  end

  context "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    params =
      { "ships"=>
        { "0"=>
          { "length"=>"2",
            "classification"=>"patrol-boat",
            "positions"=>["5-3", "5-4"]
          },
          "1"=>
          { "length"=>"3",
            "classification"=>"destroyer",
            "positions"=>["7-7", "7-8", "7-9"]
          },
          "2"=>
          { "length"=>"3",
            "classification"=>"submarine",
            "positions"=>["6-4", "6-5", "6-6"]
          },
          "3"=>
          { "length"=>"4",
            "classification"=>"battleship",
            "positions"=>["4-7", "4-8", "4-9", "4-10"]
          },
          "4"=>
          { "length"=>"5",
            "classification"=>"aircraft-carrier",
            "positions"=>["2-2", "2-3", "2-4", "2-5", "2-6"]
          }
        }
      }

    it "assigns game" do
      post :create, xhr: true, params: params
      expect(assigns(:game)).to be_instance_of Game
    end

    it "creates SetupNewGame PORO" do
      expect(SetupNewGame).to receive(:new).and_call_original
      post :create, xhr: :true, params: params
    end
  end
end
