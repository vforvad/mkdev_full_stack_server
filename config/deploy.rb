# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'mkdev_full_stack'
set :repo_url, 'git@github.com:vforvad/mkdev_full_stack_server.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/applications/mkdev_full_stack'

set :ssh_options, forward_agent: true, user: 'ec2-user', keys: ["#{ENV['HOME']}/.ssh/basic.pem"]
set :log_level, :info
set :linked_files, %w(config/database.yml config/settings.yml)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads)

set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)}
#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

set :puma_init_active_record, true
