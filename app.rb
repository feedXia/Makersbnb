require "sinatra/base"
require "sinatra/reloader"
require "pg"
require_relative "lib/space"
require_relative "lib/user"
require_relative "lib/request"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
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
      user_id: params[:user_id],
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

  get "/requests" do
    # @spaces = Space.all
    # @space = Space.find(id: session[:id])
    @space = Space.find(id: params[:id])
    Request.add(user_id: params[:user_id], space_id: space.id)
    @requests = Request.by_user(user_id: params[:user_id])
    @spaces = @requests.map do |request|
      Space.find(id: request.space_id)
    end
    erb :"requests/index"
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
    end
    redirect "/"

    # login_success ? "Log in success!" : "email or password is wrong :("
  end

  run! if app_file == $0
end
