require "sinatra/base"
require "sinatra/reloader"
require "pg"
require_relative "lib/space"
require_relative "lib/user"
require_relative "database_connection_setup"

class MakersBnB < Sinatra::Base
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

  run! if app_file == $0
end
