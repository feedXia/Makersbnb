require "sinatra/base"
require "sinatra/reloader"
require "pg"
require_relative "lib/space"
require_relative "lib/user"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    "Hello World"
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
    @spaces = Space.all
    erb :"requests/index"
  end

  get "/user/new" do
    erb :"user/new"
  end

  post "/user/new" do
    User.add(name: params[:name], email: params[:email], password: params[:password])
    "#{params[:name]}, thank you for registration!"
  end

  post "/spaces/search" do
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

  run! if app_file == $0
end
