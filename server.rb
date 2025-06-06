require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'sinatra/activerecord'
require 'logger'
require_relative 'models/user'
require_relative 'models/account'
#require_relative 'models/service'
#require_relative 'models/card'
require_relative 'models/transaction'

class App < Sinatra::Application

    set :views, File.expand_path('views', __dir__)
    set :public_folder,  File.expand_path('public', __dir__)

    enable :sessions
    set :session_secret, SecureRandom.hex(64)

  configure :development do
    enable :logging
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger

    register Sinatra::Reloader
    after_reload do
      logger.info 'Reloaded!!!'
    end
  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/signup' do
    user = User.new(
      name: params[:name],
      surname: params[:surname],
      dni: params[:dni],
      tel: params[:tel],
      email: params[:email],
      address: params[:address],
      password: params[:password]
    )

    if user.save
      session[:user_id] = user.id
      redirect '/home'
    else
      @error = user.errors.full_messages.join(', ')
      erb :register
    end
  end

  post '/login' do
    user = User.find_by(dni: params[:dni])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      @error = "DNI o contraseña incorrectos"
      erb :index
    end
  end

  get '/home' do
    redirect '/' unless session[:user_id]

    @user = User.find(session[:user_id])
    erb :home
  end
  
end
