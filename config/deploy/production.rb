# frozen_string_literal: true
ip = '52.87.203.89'

role :app, ["deploy@#{ip}"]
role :web, ["deploy@#{ip}"]
role :db,  ["deploy@#{ip}"]

server ip, user: 'deploy', roles: %w(web app db)

set :stage, 'production'
set :rails_env, 'production'
