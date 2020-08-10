# DOCKER TIPS

**BY: Luiz Eduardo**

### Para gerar o seu container através da imagem padrão do ubuntu, rode:

> `docker run -t -i ubuntu /bin/bash`

### Para verificar que o container esta no ar, em outro console rode:


```bash
root@0xmachine:/home/isweluiz# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
2f8d21f9e8c8        ubuntum``              "/bin/bash"         About a minute ago   Up About a minute                       optimistic_swirles
```


### Para parar o seu container, pegue o Id do seu container que apareceu depois do comando anterior e rode o seguinte comando:


```bash
root@0xmachine:/home/isweluiz# docker stop 2f8d21f9e8c8
2f8d21f9e8c8
```


### Agora que seu container está parado, você pode rodar o seguinte comando para listá-lo (junto com todos os outros parados):


```bash
root@0xmachine:/home/isweluiz# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
2f8d21f9e8c8        ubuntu              "/bin/bash"        3 minutes ago       Exited (0) About a minute ago                       optimistic_swirles
```


### Para que você possa voltar a ver o bash do seu container ou rodar outro comando, pegue novamente o id e rode:


```bash
root@0xmachine:/home/isweluiz# docker start 2f8d21f9e8c8
2f8d21f9e8c8
root@0xmachine:/home/isweluiz# docker exec -it 2f8d21f9e8c8 bash
```


### Agora para finalizar para novamente seu container rodando:

```bash
root@0xmachine:/home/isweluiz# docker stop 2f8d21f9e8c8
2f8d21f9e8c8

root@0xmachine:/home/isweluiz# docker rm 2f8d21f9e8c8
2f8d21f9e8c8
root@0xmachine:
```

# Criando e subindo um Projeto Rails via Docker

### Crie seu projeto Rails rodando:


```bash
root@0xmachine:/tmp/docker# docker run -it --rm --user "$(id -u):$(id -g)" -v "$PWD":/usr/src/app -w /usr/src/app rails rails new --skip-bundle my_awesome_app
Unable to find image 'rails:latest' locally
latest: Pulling from library/rails
75a822cd7888: Pull complete 
57de64c72267: Pull complete 
4306be1e8943: Pull complete 
871436ab7225: Pull complete 
afb684ad7765: Pull complete 
c2807e33cf84: Pull complete 
7025772f9b60: Pull complete 
73729083bf6c: Pull complete 
7dd42782d26e: Pull complete 
6bd3d457e27a: Pull complete 
4cd427c44fca: Pull complete 
Digest: sha256:aec52fe81ff0e99d64174001fbdf44c3bc9e1869756dec05c447f52a0fe637e7
Status: Downloaded newer image for rails:latest
      create  
      create  README.md
      create  Rakefile
      create  config.ru
      create  .gitignore
      create  Gemfile
      create  app
      create  app/assets/config/manifest.js
      create  app/assets/javascripts/application.js
      create  app/assets/javascripts/cable.js
      create  app/assets/stylesheets/application.css
      create  app/channels/application_cable/channel.rb
      create  app/channels/application_cable/connection.rb
      create  app/controllers/application_controller.rb
      create  app/helpers/application_helper.rb
      create  app/jobs/application_job.rb
      create  app/mailers/application_mailer.rb
      create  app/models/application_record.rb
      create  app/views/layouts/application.html.erb
      create  app/views/layouts/mailer.html.erb
      create  app/views/layouts/mailer.text.erb
      create  app/assets/images/.keep
      create  app/assets/javascripts/channels
      create  app/assets/javascripts/channels/.keep
      create  app/controllers/concerns/.keep
      create  app/models/concerns/.keep
      create  bin
      create  bin/bundle
      create  bin/rails
      create  bin/rake
      create  bin/setup
      create  bin/update
      create  config
      create  config/routes.rb
      create  config/application.rb
      create  config/environment.rb
      create  config/secrets.yml
      create  config/cable.yml
      create  config/puma.rb
      create  config/spring.rb
      create  config/environments
      create  config/environments/development.rb
      create  config/environments/production.rb
      create  config/environments/test.rb
      create  config/initializers
      create  config/initializers/application_controller_renderer.rb
      create  config/initializers/assets.rb
      create  config/initializers/backtrace_silencers.rb
      create  config/initializers/cookies_serializer.rb
      create  config/initializers/cors.rb
      create  config/initializers/filter_parameter_logging.rb
      create  config/initializers/inflections.rb
      create  config/initializers/mime_types.rb
      create  config/initializers/new_framework_defaults.rb
      create  config/initializers/session_store.rb
      create  config/initializers/wrap_parameters.rb
      create  config/locales
      create  config/locales/en.yml
      create  config/boot.rb
      create  config/database.yml
      create  db
      create  db/seeds.rb
      create  lib
      create  lib/tasks
      create  lib/tasks/.keep
      create  lib/assets
      create  lib/assets/.keep
      create  log
      create  log/.keep
      create  public
      create  public/404.html
      create  public/422.html
      create  public/500.html
      create  public/apple-touch-icon-precomposed.png
      create  public/apple-touch-icon.png
      create  public/favicon.ico
      create  public/robots.txt
      create  test/fixtures
      create  test/fixtures/.keep
      create  test/fixtures/files
      create  test/fixtures/files/.keep
      create  test/controllers
      create  test/controllers/.keep
      create  test/mailers
      create  test/mailers/.keep
      create  test/models
      create  test/models/.keep
      create  test/helpers
      create  test/helpers/.keep
      create  test/integration
      create  test/integration/.keep
      create  test/test_helper.rb
      create  tmp
      create  tmp/.keep
      create  tmp/cache
      create  tmp/cache/assets
      create  vendor/assets/javascripts
      create  vendor/assets/javascripts/.keep
      create  vendor/assets/stylesheets
      create  vendor/assets/stylesheets/.keep
      remove  config/initializers/cors.rb
```

### Agora entre no diretório via console e crie um file chama "Dockerfile" e substitua o conteúdo dele por:

Reference(https://www.ctl.io/developers/blog/post/how-to-deploy-a-rails-app-with-docker-using-official-images)


```dockerfile
FROM ruby:2.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app


RUN apt-get update ; apt-get install -y nodejs --no-install-recommends ; rm -rf /var/lib/apt/lists/*
RUN apt-get update ; apt-get install -y sqlite3 --no-install-recommends ; rm -rf /var/lib/apt/lists/*

#COPY Gemfile /usr/src/app/

#RUN bundle install

#COPY . /usr/src/app

EXPOSE 3000
CMD puma -C config/puma.rb
```

### Agora que criamos nosso Dockerfile podemos fazer o Build da nossa imagem (Construir nossa imagem personalizada), dentro da pasta do seu projeto rode:


```bash
root@0xmachine:/tmp/docker# docker build -t my_awesome_app .
```

### Depois disso podemos pegar a imagem que geramos e criar nosso container para subir nossa aplicação, no seu console rode: