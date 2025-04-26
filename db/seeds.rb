require 'faker'
require 'json'
require 'httparty'

# Quantidade
TOTAL_USERS = 100
TOTAL_POSTS = 200_000
TOTAL_RATINGS = (TOTAL_POSTS * 0.75).to_i
UNIQUE_IPS = Array.new(50) { Faker::Internet.unique.ip_v4_address }

# Limpeza dos bancos antes de começar
Rails.logger.debug "Limpando bancos de dados..."
Rating.delete_all
Post.delete_all
User.delete_all
Rails.logger.debug "Bancos limpos com sucesso!"

# Criação de posts
user_ids = []
post_ids = []
Rails.logger.debug "Gerando posts..."
TOTAL_POSTS.times do |_i|
  login = Faker::Internet.unique.username
  rand(1..TOTAL_USERS)
  title = 'teste de titulo'
  body = 'teste de texto não utilizei faker para o processamentos ser mais rápido'
  ip = UNIQUE_IPS.sample

  payload = {
    user: { login: login },
    post: {
      title: title,
      body: body,
      ip: ip
    }
  }

  begin
    response = HTTParty.post('http://localhost:3000/api/v1/posts',
                             body: payload.to_json,
                             headers: { 'Content-Type' => 'application/json' })

    if response.success?
      json = JSON.parse(response.body)
      user_ids << json['user']['id'] unless user_ids.include?(json['user']['id'])
      post_ids << json['post']['id']
    else
      Rails.logger.debug { "Erro ao criar post: #{response.code} - #{response.body}" }
    end
  rescue StandardError => e
    Rails.logger.debug { "Exceção ao fazer requisição: #{e.message}" }
  end
end

# Criação de ratings
Rails.logger.debug "Gerando ratings..."
TOTAL_RATINGS.times do
  value = rand(1..5)

  payload = {
    rating: {
      post_id: post_ids.sample,
      user_id: user_ids.sample,
      value: value
    }
  }

  HTTParty.post('http://localhost:3000/api/v1/ratings',
                body: payload.to_json,
                headers: { 'Content-Type' => 'application/json' })
end
