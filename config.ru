$curr_path = File.expand_path(File.dirname(__FILE__))
$:.unshift $curr_path
require 'sinatra/base'
require 'erb'
require 'gollum/app'
$authorized_users =  YAML.load_file(File.expand_path('users.yml', $curr_path))

gollum_path = File.expand_path(File.dirname(__FILE__)) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:template_dir, '/home/shivil/code/lab/interview/2224709/wikidata/')
Precious::App.set(:private, true)
wiki_options = {}
wiki_options[:live_preview] = false
Precious::App.set(:wiki_options, wiki_options)

load 'user.rb'
map '/user' do
    run User
end
map '/' do
    run Precious::App
end
