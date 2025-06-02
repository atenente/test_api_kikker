# Teste Kikker API

[![Ruby](https://img.shields.io/badge/Ruby-v3.4.3-red)](https://www.ruby-lang.org/pt/downloads/)
[![Rails](https://img.shields.io/badge/Rails-v7.1-red)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-v14-blue)](https://www.postgresql.org/)

## 🚧 Status do Projeto

Especificações:
[Arquivo de referência](https://docs.google.com/document/d/1l9iYKMIyJ8DL8-dnkPiMIEdNkfMORlRvWrYpxzkCo9I/edit?tab=t.0#heading=h.35ylukesiwyo)

Documentação de desenvolvimento:
[Fluxo Kamban](https://github.com/users/atenente/projects/7)

## 🛠️ Principais Tecnologias Utilizadas
- **Ruby 3.4.2** - Linguagem de programação utilizada no projeto.
- **Rails 7.1.3** - Framework principal.
- **PostgreSQL** - Banco de dados relacional.
- **rack-cors** - Permite requisições entre domínios diferentes (CORS)
- **rspec-rails** - Framework de testes
- **simplecov** - Verificar cobertura de testes
- **sidekiq** - Para processos em segundo plano

## 🔗 Entrypoints

<details>
  <summary>Posts</summary>

  [![Generic badge](https://img.shields.io/badge/Request-POST-blue.svg)](https://img.shields.io/)

  ```
  http://localhost:3000/api/v1/posts
  ```

  ### Body.json
  {
    "user": { "login": "string" },
    "post": {
      "title": "string",
      "body": "text",
      "ip": "string"
    }
  }
</details>

<details>
  <summary>Ratings</summary>

  [![Generic badge](https://img.shields.io/badge/Request-POST-blue.svg)](https://img.shields.io/)

  ```
  http://localhost:3000/api/v1/ratings
  ```

  ### Body.json
  {
      "rating": {
      "post_id": 1,
      "user_id": 2,
      "value": 5
      }
  }
</details>
<details>
  <summary>Relatórios</summary>

  [![Generic badge](https://img.shields.io/badge/Request-GET-green.svg)](https://img.shields.io/)

  ```
  http://localhost:3000/api/v1/posts
  ```
  ```
  http://localhost:3000/api/v1/posts/top_posts
  ```
  ```
  http://localhost:3000/api/v1/posts/authors_ips
  ```

</details>

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Ruby](https://www.ruby-lang.org/pt/downloads/) - Versão 3.4.3
- [Rails](https://rubygems.org/gems/rails/versions/7.1.3) - Versão 7.1.3
- [PostgreSQL](https://www.postgresql.org/download/) - Versão 14
- [Redis](https://github.com/redis/redis) - Versão >= 7 para execução de jobs com Sidekiq

### Instalação

1. Clone o repositório:

  ```bash
    git clone https://github.com/atenente/test_api_kikker.git
    cd test_api_kikker
    bin/setup
    rails s
  ```

2. Popular dados:

  ```bash
    rails db:seed
  ```

3. Processamento em background:

  ```bash
    sudo service redis-server start
  ```

  ```bash
    bundle exec sidekiq
  ```

  ```
    http://localhost:3000/sidekiq
  ```

4. Testes:

  ```bash
    rspec
  ```
  ```bash
    rubocop
  ```

### Docker

1. Criando ambientes:

  ```bash
    sudo docker-compose build
  ```

2. Iniciando:

  ```bash
    sudo docker-compose up
  ```

