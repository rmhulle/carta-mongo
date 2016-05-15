require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/unicorn'
require 'mina/rvm'

# IP do seu servidor
set :domain, '159.203.97.203'

# Caminho da pasta de deploy
set :deploy_to, '/home/deploy/apps/carta-sesa'

# Repositorio do seu github/gitlab/bitbucket
set :repository, 'git@github.com:rmhulle/carta-mongo.git'
# Branch do projeto
set :branch, 'master'
# Porta do seu servidor ssh
set :port, '22'

# Permitir por senha o deploy
set :term_mode, nil

# Caminho do RVM instalado. Ele ja assume que estara no caminho padrao. Caso nao, modifique aqui:
# set :rvm_path, '/usr/local/rvm/bin/rvm'

# Arquivos compartilhados
set :shared_paths, ['config/mongoid.yml' 'config/secrets.yml', 'log']
set :app_path, "#{deploy_to}/#{current_path}"
set :stage, 'production'
# Quantidade de releases para manter em producao
set :keep_releases, 4

# Seu usuario de deploy
set :user, 'deploy'

# PID do unicorn
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

task :environment do
  # defina a versao do Ruby que vai usar e a gemset
  invoke :'rvm:use[ruby-2.2.3@carta-sesa]'
end

task :setup => :environment do
  # Pastas compartilhadas
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  # UNICORN
  # /home/deploy/apps/<app>/shared/pids/unicorn.pid
  #
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/pids"]

  # /home/deploy/apps/<app>/shared/sockets/unicorn.sock
  #
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/sockets"]

  # YML
  queue! %[touch "#{deploy_to}/#{shared_path}/config/mongo.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue  %[echo "-----> EDITE no seu servidor o arquivo '#{deploy_to}/#{shared_path}/config/mongoid.yml'."]
  queue  %[echo "-----> EDITE no seu servidor o arquivo '#{deploy_to}/#{shared_path}/config/secrets.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'

      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end
