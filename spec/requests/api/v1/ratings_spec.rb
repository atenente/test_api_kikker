require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :request do
  describe 'POST /api/v1/ratings' do
    let(:user_id) { 1 }
    let(:post_record) { create(:post, user_id: user_id) }

    context 'com parâmetros válidos' do
      it 'cria a avaliação e retorna a média atualizada' do
        create(:rating, post: post_record, value: 3)

        post '/api/v1/ratings', params: {
          rating: {
            post_id: post_record.id,
            user_id: user_id,
            value: 5
          }
        }.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['average_rating']).to eq(4.0)
      end
    end

    context 'com valor inválido' do
      it 'retorna erros de validação' do
        post '/api/v1/ratings', params: {
          rating: {
            post_id: post_record.id,
            user_id: user_id,
            value: 8
          }
        }.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end
    end

    context 'com user_id inexistente' do
      it 'não encontra o post e retorna erro' do
        post '/api/v1/ratings', params: {
          rating: {
            post_id: post_record.id,
            user_id: 999, # user_id que não existe
            value: 4
          }
        }.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end
    end
  end
end
