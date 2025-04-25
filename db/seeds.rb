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

  HTTParty.post('http://localhost:3000/api/v1/posts',
                body: payload.to_json,
                headers: { 'Content-Type' => 'application/json' })
end

# Criação de ratings
Rails.logger.debug "Gerando ratings..."
used_votes = {}
TOTAL_RATINGS.times do
  post_id = rand(1..TOTAL_POSTS)
  user_id = rand(1..TOTAL_USERS)
  key = "#{user_id}-#{post_id}"

  next if used_votes[key] # garante um voto por usuário por post

  used_votes[key] = true
  value = rand(1..5)

  payload = {
    rating: {
      post_id: post_id,
      user_id: user_id,
      value: value
    }
  }

  HTTParty.post('http://localhost:3000/api/v1/ratings',
                body: payload.to_json,
                headers: { 'Content-Type' => 'application/json' })
end
