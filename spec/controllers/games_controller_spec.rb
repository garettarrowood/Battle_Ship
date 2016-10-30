require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { create(:game,
               boards: [
                 create(:board, owner: "2000"),
                 create(:board, owner: "comp")
               ]
             )}

  before(:each) do
    @user = create(:user, id: 2000, games: [game])
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
    it "assigns game" do
      params = {"ships"=> ships_json}
      post :create, xhr: true, params: params
      expect(assigns(:game)).to be_instance_of Game
    end

    it "creates SetupNewGame PORO" do
      params = {"ships"=> ships_json}
      expect(SetupNewGame).to receive(:new).and_call_original
      post :create, xhr: :true, params: params
    end
  end

  context "GET #show" do
    it "assigns game" do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it "assigns opponent_board" do
      get :show, params: { id: game.id }
      expect(assigns(:opponent_board)).to be_instance_of Board
    end

    it "assigns user_board" do
      get :show, params: { id: game.id }
      expect(assigns(:user_board)).to be_instance_of Board
    end

    it "renders the show template" do
      get :show, params: { id: game.id }
      expect(response).to render_template("show")
    end
  end

  context "PUT #apply_win" do
    it "assigns game" do
      put :apply_win, params: { game_id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it "calls UpdateStats with user_win" do
      expect(UpdateStats).to receive(:user_wins).and_call_original
      put :apply_win, params: { game_id: game.id }
    end

    it "redirects to #won" do
      put :apply_win, params: { game_id: game.id }
      expect(response).to redirect_to :game_won
    end
  end

  context "GET #won" do
    it "assigns game" do
      get :won, params: { game_id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it "assigns moves" do
      get :won, params: { game_id: game.id }
      expect(assigns(:moves)).to be_instance_of Fixnum
    end

    it "assigns lost_ships" do
      get :won, params: { game_id: game.id }
      expect(assigns(:lost_ships)).to be_instance_of Fixnum
    end

    it "renders the won template" do
      get :won, params: { game_id: game.id }
      expect(response).to render_template("won")
    end
  end

  context "PUT #apply_loss" do
    it "assigns game" do
      put :apply_loss, params: { game_id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it "calls UpdateStats with user_loses" do
      expect(UpdateStats).to receive(:user_loses).and_call_original
      put :apply_loss, params: { game_id: game.id }
    end

    it "redirects to #lost" do
      put :apply_loss, params: { game_id: game.id }
      expect(response).to redirect_to :game_lost
    end
  end

  context "GET #lost" do
    it "assigns game" do
      get :lost, params: { game_id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it "assigns moves" do
      get :lost, params: { game_id: game.id }
      expect(assigns(:moves)).to be_instance_of Fixnum
    end

    it "assigns destroyed_ships" do
      get :lost, params: { game_id: game.id }
      expect(assigns(:destroyed_ships)).to be_instance_of Fixnum
    end

    it "renders the lost template" do
      get :lost, params: { game_id: game.id }
      expect(response).to render_template("lost")
    end
  end
end
