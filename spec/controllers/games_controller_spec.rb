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

    it "sets game if one exists on user" do
      get :index
      expect(assigns(:game)).to be nil

      game = @user.games.create
      get :index
      expect(assigns(:game).id).to be game.id
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
end
