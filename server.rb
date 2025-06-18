require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'sinatra/activerecord'
require 'logger'
require_relative 'models/user'
require_relative 'models/account'
require_relative 'models/service'
require_relative 'models/card'
require_relative 'models/payed_service'
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
      begin
        Account.create!(
          user: user,
          cvu: generate_unique_cvu,
          alias: user.name + user.surname,
          total_balance: 0,
          creation_date: Time.now,
          password: user.password
        )

        session[:user_id] = user.id
        redirect '/home'
      rescue ActiveRecord::RecordInvalid => e
        user.destroy # revertimos si falla la creación de la cuenta
        @error = "Error al crear la cuenta: #{e.message}"
        erb :register
      end
    else
      @error = user.errors.full_messages.join(', ')
      erb :register 
    end
  end
  
  def generate_unique_cvu
    loop do
      cvu = rand(10**16).to_s.rjust(16, '0')
      break cvu unless Account.exists?(cvu: cvu)
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
    @last_transactions = @user.account&.source_transactions&.order(date: :desc)&.limit(5) || []
    erb :home
  end
  
  get '/transfer' do 
    @user = User.find(session[:user_id])
    erb :transfer
  end

  post '/transfer' do
    sender_account = User.find(session[:user_id]).account
    receiver_account = Account.find_by(alias: params[:dest_alias])
    amount = params[:amount].to_i

    if receiver_account.nil?
      @error = "Cuenta destino no encontrada."
    elsif receiver_account == sender_account
      @error = "No podés transferirte a vos mismo."
    elsif amount <= 0
      @error = "El monto debe ser mayor a cero."
    elsif sender_account.total_balance < amount
      @error = "Saldo insuficiente."
    else
      # delegamos a Transaction
      begin
        Transaction.transfer_money_by_alias(sender_account.alias, receiver_account.alias, amount)
        @success = "Transferencia realizada con éxito."
      rescue => e
        @error = "Ocurrió un error: #{e.message}"
      end
    end

    @user = User.find(session[:user_id])
    erb :transfer
  end

  get '/insert_money'do
    @user = User.find(session[:user_id])
    erb :insert_money
  end

  post '/insert_money' do
    account = User.find(session[:user_id]).account
    amount = params[:amount].to_i

    if account.nil? 
      @error = "Cuenta no encontrada."
    elsif amount <= 0
      @error = "El monto debe ser mayor que cero."
    else 
      begin
      account.update!(total_balance: account.total_balance + amount)
      @success = "Dinero ingesado con exito."
      # redirect '/home'
      # return
      end
    end
    @user = User.find(session[:user_id])
    erb :insert_money

  end


end