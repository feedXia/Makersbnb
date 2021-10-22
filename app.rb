require "sinatra/base"
require "sinatra/reloader"
require "pg"
require_relative "lib/space"
require_relative "lib/user"
require_relative "lib/request"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
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
      user_id: session[:user_id],
    )
    redirect "/spaces"
  end

  get "/spaces" do
    @spaces = Space.all
    erb :"spaces/index", :layout => :layout
  end

  get "/spaces/:id" do
    @space = Space.find(id: params[:id])
    erb :"spaces/each", :layout => :layout
  end

  get "/user/new" do
    erb :"user/new"
  end

  post "/user/new" do
    user = User.add(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/"
    "#{params[:name]}, thank you for registration!"
  end

  get "/user/login" do
    erb :"user/login"
  end

  post "/user/login" do
    user = User.login(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
    else
      flash[:notice] = "Email or password is wrong :("
      redirect "/"
    end

    # login_success ? "Log in success!" : "email or password is wrong :("
  end

  get "/requests" do
    @space = Space.find(id: session[:space_id])
    p @space
    @requested = Request.add(user_id: @space[0].user_id, space_id: session[:space_id])
    p @requested
    erb :"requests/new", :layout => :layout
  end

  post "/requests/:id" do
    session[:space_id] = params[:id]
    redirect "/requests"
  end

  # post "/requests/new" do
  #   space = Space.find(id: session[:space_id])
  #   Request.add(user_id: session[:user_id], space_id: space.id)
  #   flash[:notice] = "Thanks for your request"
  #   redirect "/spaces"
  # end

  run! if app_file == $0
end
