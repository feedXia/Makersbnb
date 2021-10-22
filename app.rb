require "sinatra/base"
require "sinatra/reloader"
require "pg"
require "sinatra/flash"
require_relative "lib/space"
require_relative "lib/user"
require_relative "lib/request"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get "/" do
    @user = User.find(id: session[:user_id])
    erb :index
  end

  get "/spaces/new" do
    erb :"/spaces/new", :layout => :layout
  end

  post "/spaces/new" do
    Space.add(
      name: params[:name],
      description: params[:description],
      price: params[:price_night],
      from: params[:from],
      to: params[:to],
      user_id: session[:user_id],
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

  get "/requests" do
    @space = Space.find(id: session[:space_id])
    p @space
    @requested = Request.add(user_id: @space[0].user_id, space_id: session[:space_id])
    p @requested
    erb :"requests/new", :layout => :layout
  end

  post "/search" do
    # p "SESSION POST:"
    # p session[:spaces_available]
    session[:spaces_available] = Space.available(from: params[:user_from], to: params[:user_to])
    redirect "/search"
  end

  get "/search" do
    # p "SESSION GET:"
    # p session[:spaces_available]
    @spaces_available = session[:spaces_available]
    erb :"spaces/search", :layout => :layout
  end

  post "/requests/:id" do
    session[:space_id] = params[:id]
    redirect "/requests"
  end

  post "/requests/new" do
    space = Space.find(id: session[:space_id])
    Request.add(user_id: session[:user_id], space_id: space.id)
    flash[:notice] = "Thanks for your request"
    redirect "/spaces"
  end

  run! if app_file == $0
end
