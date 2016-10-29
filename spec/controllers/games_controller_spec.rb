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
end
