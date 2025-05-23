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

  get '/home' do
    erb :home
  end
  
end
