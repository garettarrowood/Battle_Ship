# frozen_string_literal: true

require 'rails_helper'

describe MultiplayerController, type: :controller do
  let(:game) do
    create(
      :game,
      multiplayer?: true,
      status: 'ongoing',
      boards: [
        create(:board, owner: '1000'),
        create(:board)
      ]
    )
  end

  before(:each) do
    @user = create(:user, id: 1000, games: [game])
    log_in @user
  end

  context 'POST #create' do
    it 'assigns game' do
      params = { ships: ships_json }
      post :create, xhr: true, params: params
      expect(assigns(:game)).to be_instance_of Game
    end

    it 'if NO pending multiplayer game, creates new one' do
      params = { ships: ships_json }
      expect { post :create, xhr: true, params: params }
        .to change { Game.count }.by(1)
    end

    it 'if pending multplayer game, does NOT create new one' do
      Game.create(multiplayer?: true, status: 'pending')
      params = { ships: ships_json }
      expect { post :create, xhr: true, params: params }
        .to change { Game.count }.by(0)
    end
  end

  context 'GET #show' do
    it 'assigns game' do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it 'assigns user_board' do
      get :show, params: { id: game.id }
      expect(assigns(:user_board)).to be_instance_of Board
    end

    it 'renders the show template' do
      get :show, params: { id: game.id }
      expect(response).to render_template('show')
    end
  end

  context 'GET #opponent_forfeit' do
    it 'assigns game' do
      get :opponent_forfeit, params: { multiplayer_id: game.id }
      expect(assigns(:game)).to be_instance_of Game
    end

    it 'if game is not over, broadcasts using ActionCable' do
      expect(ActionCable).to receive(:server).and_call_original
      get :opponent_forfeit, params: { multiplayer_id: game.id }
    end

    it 'if game is not over, calls UpdateStats with user_win' do
      expect(UpdateStats).to receive(:user_wins).and_call_original
      get :opponent_forfeit, params: { multiplayer_id: game.id }
    end

    it 'if game is over, does not broadcast or update' do
      game.update(status: 'over')
      expect(ActionCable).to_not receive(:server).and_call_original
      expect(UpdateStats).to_not receive(:user_wins).and_call_original
      get :opponent_forfeit, params: { multiplayer_id: game.id }
    end

    it 'renders the show template' do
      get :opponent_forfeit, params: { multiplayer_id: game.id }
      expect(response).to render_template('opponent_forfeit')
    end
  end

  context 'GET #disconnected' do
    it 'calls UpdateStats with user_loses' do
      expect(UpdateStats).to receive(:user_loses).and_call_original
      get :disconnected
    end
  end
end
