require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:headers) {
    {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    }
  }
  let(:params) { { user: attributes_for(:user) } }

  context 'when user is unauthenticated' do
    before { post url, params: params.to_json, headers: headers }

    let(:json) { JSON.parse(response.body) }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      expect(json['email']).to eq(params[:user][:email])
    end
  end

  context 'when user already exists' do
    before do
      create(:user, email: params[:user][:email])
      post url, params: params.to_json, headers: headers
    end

    let(:json) { JSON.parse(response.body) }

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
