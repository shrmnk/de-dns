require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/login' }
  let(:headers) {
    {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    }
  }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params.to_json, headers: headers
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JWT token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      token_from_request = response.headers['Authorization'].split(' ').last
      decoded_token = JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)

      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    let(:params) do
      {
        user: {
          email: user.email,
          password: 'bad password'
        }
      }
    end

    before { post url, params: params.to_json, headers: headers }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end

    it 'does not return JWT token in authorization header' do
      expect(response.headers['Authorization']).not_to be_present
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/logout' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end
