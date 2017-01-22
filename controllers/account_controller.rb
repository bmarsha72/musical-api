class AccountController < ApplicationController

  get '/' do
    #login /registration page
  end

  post '/register' do
    #accept the params from a post to create a user (bcrypt)
    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
    if does_user_exist?(@username) == true
      @account_message = "User Already Exists"
      return erb :login_notice
    end

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(@password, password_salt)

    @model = Account.new
    @model.username = @username
    @model.email = @email
    @model.password_hash = @password_hash
    @model.password_salt = @password_salt
    @model.save

    @account_message = "You have successfully registered"

    erb :login_notice

  end

  post '/login' do
    # params { :username, :password, :email }
    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
    #accept params from a post to check if a user exists
    #and if so, log them in
  end

  get '/logout' do
    session[:user] = nil
    redirect '/'
    #user leaves - set session to nil.  they will need to log in again
  end

  get '/supersecret' do
    # test of user authentication
    # hide some hash/json and only show to logged in users
  end




end
