# frozen_string_literal: true
ip = '54.161.73.233'

role :app, ["deploy@#{ip}"]
role :web, ["deploy@#{ip}"]
role :db,  ["deploy@#{ip}"]

server ip, user: 'ec2-user', roles: %w(web app db)

set :stage, 'production'
set :rails_env, 'production'
