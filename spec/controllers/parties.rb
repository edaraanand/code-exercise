require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe 'GET #index' do
    context 'with no params' do
      before(:each) do
        @party1 = FactoryGirl.create(:party)
        @party2 = FactoryGirl.create(:party)
        get :index, valid_session
      end

      it 'assigns all parties as @parties' do
        expect(assigns(:parties)).to include(@party1)
        expect(assigns(:parties)).to include(@party2)
        expect(assigns(:parties).size).to eq 2
      end

      it 'returns http success' do
        expect(response).to be_success
      end
    end
    context 'with sorting params' do
      before(:each) do
        @party1 = FactoryGirl.create(:party)
        @party2 = FactoryGirl.create(:party)
        get :index, {sort: 'host_name', asc: true}, valid_session
      end

      it 'sortOrder asc' do
        expect(assigns(:parties).size).to eq Party.order(host_name: :asc)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'should create a new party' do
        post :create, create_party_params

        expect(response.status).to eq 201
      end
    end
    context 'with invalid parameters' do
      it 'should create a new party' do
        expect {
          post :create, invalid_create_party_params
        }.to raise_error
      end
    end
  end

end