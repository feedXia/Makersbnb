require "sinatra/base"
require "sinatra/reloader"
require "pg"
require 'sinatra/flash'
require_relative "lib/space"
require_relative "lib/user"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
  register Sinatra::Flash
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get "/" do
    @user = User.find(id: session[:user_id])
    erb :"index"
  end

  get "/spaces/new" do
    erb :"/spaces/new", :layout => :layout
  end

  post "/spaces/new" do
    Space.add(
      name: params[:name],
      description: params[:description],
      price: params[:price_night],
    )
    redirect "/spaces"
  end

  get "/spaces" do
    @user = User.find(id: session[:user_id])
    @spaces = Space.all
    erb :"spaces/index", :layout => :layout
  end

  get "/spaces/:id" do
    @user = User.find(id: session[:user_id])
    @space = Space.find(id: params[:id])
    erb :"spaces/each", :layout => :layout
  end

  get "/requests" do
    @user = User.find(id: session[:user_id])
    @spaces = Space.all
    erb :"requests/index", :layout => :layout
  end

  get "/user/new" do
    erb :"user/new", :layout => :layout
  end

  post "/user/new" do
    user = User.add(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/spaces"
  end

  get "/user/login" do
    erb :"user/login", :layout => :layout
  end

  post "/user/login" do
    user = User.login(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect "/spaces"
    else
      "Email or password incorrect."
    end
  end

  post "/user/signout" do
    session.clear
    flash[:notice] = "You have been signed out."
    redirect "/"
  end

  run! if app_file == $0
end
