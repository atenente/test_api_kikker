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

## Entrypoints

<details>
  <summary>Posts</summary>
  ### Requests

  [![Generic badge](https://img.shields.io/badge/Request-POST-blue.svg)](https://img.shields.io/)

  ```
  http://localhost:3000/api/v1/posts
  ```

  ### Body.json
  {
    user: { login: string },
    post: {
      title: string,
      body: text,
      ip: strinh
    }
  }
</details>

<details>
  <summary>Ratings</summary>

  ### Requests

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



## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Ruby](https://www.ruby-lang.org/pt/downloads/) - Versão 3.4.3
- [Rails](https://rubygems.org/gems/rails/versions/7.1.3) - Versão 7.1.3
- [PostgreSQL](https://www.postgresql.org/download/) - Versão 14

### Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/atenente/test_api_kikker.git
   cd test_api_kikker
