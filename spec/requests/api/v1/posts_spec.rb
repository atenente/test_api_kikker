require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  describe 'POST /api/v1/posts' do
    let(:login) { Faker::Internet.unique.username }

    let(:valid_params) do
      {
        user: { login: login },
        post: {
          title: Faker::Book.title,
          body: Faker::Lorem.paragraph,
          ip: Faker::Internet.ip_v4_address
        }
      }
    end

    let(:invalid_params) { { user: { login: '' }, post: { title: '', body: '', ip: '' } } }

    it 'cria um novo post e usuário se necessário' do
      expect do
        post '/api/v1/posts', params: valid_params
      end.to change(Post, :count).by(1).and change(User, :count).by(1)

      expect(response).to have_http_status(:created)

      json = response.parsed_body
      expect(json['post']['title']).to eq(valid_params[:post][:title])
      expect(json['post']['body']).to eq(valid_params[:post][:body])
      expect(json['post']['ip']).to eq(valid_params[:post][:ip])
      expect(json['user']['login']).to eq(login)
    end

    it 'retorna erro se campos obrigatórios estiverem ausentes' do
      post '/api/v1/posts', params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      json = response.parsed_body
      expect(json['errors']).to be_present
    end
  end
end
