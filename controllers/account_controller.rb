class AccountController < ApplicationController

  @username = ""


  get '/' do
    #login /registration page
    erb :login
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

    #binding.pry

    @model = Account.new
    @model.username = @username
    @model.email = @email
    @model.password_hash = password_hash
    @model.password_salt = password_salt
    @model.save

    @account_message = "You have successfully registered and logged in"

######################## why the fuck does this work?!?!?
session[:user] = @model
@username = session[:user][:username]
erb :login_notice
########################

  end


  post '/login' do
    # params { :username, :password, :email }
    @username = params[:username]
    @password = params[:password]
    #accept params from a post to check if a user exists
    #and if so, log them in
    if does_user_exist?(@username) == false
      @account_message = "User Already Exists"
      return erb :login_notice
    end

    @model = Account.where(:username => @username).first!
    if @model.password_hash == BCrypt::Engine.hash_secret(@password, @model.password_salt)
      @account_message = "Welcome Back"

#########################
session[:user] = @model
@username = session[:user][:username]
return erb :login_notice
#########################

    else
      @account_message = "Password did not match, try again"
      return erb :login_notice
    end
  end


  get '/logout' do
    session[:user] = nil
    @username = nil
    redirect '/'
    #user leaves - set session to nil.  they will need to log in again
  end

  post '/song' do

    @songbish = Song.new
    @songbish.songname      = params[:song]
    @songbish.songduration  = params[:duration]
    @songbish.songartist    = params[:artist]
    @songbish.save

  end

  get '/song' do
    
  #########################
  session[:user] = @username
  @account_message = "enter a song"
  return erb :song
  #########################

  end


  get '/supersecret' do
    # test of user authentication
    # hide some hash/json and only show to logged in users
    if is_not_authenticated == false
      erb :secret_club
    else
      @account_message = "You shall not pass!"
      erb :login_notice
    end
  end


end
