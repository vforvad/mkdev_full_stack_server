# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'mkdev_full_stack'
set :repo_url, 'git@github.com:vforvad/mkdev_full_stack_server.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/applications/mkdev_full_stack'

set :ssh_options, forward_agent: true, user: 'deploy', keys: ["#{ENV['HOME']}/.ssh/basic.pem"]
set :log_level, :info
set :linked_files, %w(config/database.yml config/settings.yml)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads)

set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
# rubocop:disable LineLength
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# rubocop:enable LineLength
set :rbenv_roles, :all

set :puma_init_active_record, true

desc 'Run rake tasks on server'
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: :production do
        execute :rake, ENV['task'], 'RAILS_ENV=production'
      end
    end
  end
end
