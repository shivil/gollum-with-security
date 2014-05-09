module Precious
  class App
    enable :sessions
    # use Rack::Session::Cookie, { :key => 'rack.session', :secret => "123", :expire_after => (1 * 365 * 24 * 60 * 60) }

    before /^\/(edit|delete|livepreview|revert|create)/ do
      authenticate
    end
    helpers do
      def authenticate
        if session[:user].nil?
         redirect to('/user/login')
        end
      end
    end
  end
end

class User < Sinatra::Base
  enable :sessions
  before { base_url }
  helpers do
    def base_url
      $base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end
  end
  get '/login' do
    'Hello World!'
    erb :login
  end
  get '/logout' do
    session[:user] = nil
  end
  post '/authenticate' do
    user = $authorized_users.keys.include? params["username"]
     if user.nil?
      erb :login
     elsif $authorized_users[params["username"]]["password"] == params["password"]
      session[:user] = user
        redirect to("#{$base_url}/pages")
     else
      erb :login
     end
     # "--- #{$authorized_users}"
    # redirect to('/api')
    
  end
  
end
