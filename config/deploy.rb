require 'bundler/capistrano'
require 'capistrano/ext/multistage'
#require 'whenever/capistrano'

load 'config/deploy/recipes/base'
load 'config/deploy/recipes/backup'
load 'config/deploy/recipes/check'
load 'config/deploy/recipes/db'
load 'config/deploy/recipes/nginx'
load 'config/deploy/recipes/symlinks'
load 'config/deploy/recipes/unicorn'
load 'config/deploy/recipes/assets'
load 'config/deploy/recipes/postgresql'
#load 'config/deploy/recipes/whenever'
load 'config/deploy/recipes/monit'

set :stages, %w(staging production)

set :default_stage, 'production'

default_run_options[:pty] = true

set :application, 'ab2014-tantuni'
set :user, 'deployer' # We use deployer
set :deploy_to, "/home/#{user}/apps/#{application}"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:sly01/#{application}.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :maintenance_template_path, File.expand_path('../deploy/recipes/templates/maintenance.html.erb', __FILE__)

# Production
set :default_environment, {
    'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH'
}