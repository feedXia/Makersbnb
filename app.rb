require "sinatra/base"
require "sinatra/reloader"
require "pg"
require_relative "lib/space"

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    "Hello World"
  end

  get "/spaces/new" do
    erb :"/spaces/new"
  end

  post "/spaces/new" do
    Space.add(
      name: params[:name],
      description: params[:description],
      price: params[:price_night],
    )
    redirect "/spaces/"
  end

  get "/spaces/" do
    @spaces = Space.all
    erb :"spaces/index"
  end

  get "/spaces/:id" do
    @space = Space.find(id: params[:id])
    erb :"spaces/each"
  end

  get "/request" do
    erb :"request/index"
  end

  run! if app_file == $0
end
