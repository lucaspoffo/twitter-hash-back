# Twitter Hashtag Back

Aplicação que consome a API do Twitter para armazenar tweets que contenham hashtags que forem desejadas. Fornece um API para filtrar os tweets salvos e adicionar/remover as hashtags de controle.

## Ruby on Rails

Foi utilizado essa framework de aplicação web, no modo de API, para o desenvolvimento desse aplicativo. Utilizando as rotas de recursos no modelo REST fornecidos pelo rails, facilitou a criação de modelos e fornece-los por uma API.

## Instalação

- [Rails](http://installrails.com/)
- [Postgres](https://www.postgresql.org/)

#### Comandos

    $ git clone https://github.com/lucaspoffo/twitter-hash-back.git
    $ cd twitter-hash-back
    $ bundle install
    $ rake db:setup

#### Configurações
- Definir as Variáveis de Ambiente para as chaves secretas da API do Twitter e para senha de acesso ao Postgress:

```
POSTGRES_PASSWORD=<SENHA_POSTGRESS>
TWITTER_CONSUMER_KEY=<API_KEY>
TWITTER_CONSUMER_SECRET=<API_SECRET_KEY>
TWITTER_ACCESS_TOKEN=<ACCESS_TOKEN>
TWITTER_ACCESS_SECRET=<ACCESS_TOKEN_SECRET>
```

Para subir o ambiente de desolvovimento execute o comando:
    
    $ rails server
