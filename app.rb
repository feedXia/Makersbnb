require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require_relative 'lib/space'

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
    result = params[:name] + "\n" + params[:description] + "\n" + params[:price_night]
  end

  get "/spaces/" do
    @spaces = Space.all
    erb :"spaces/index"
  end

  run! if app_file == $0
end
