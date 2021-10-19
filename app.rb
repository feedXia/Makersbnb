require "sinatra/base"
require "sinatra/reloader"

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

  run! if app_file == $0
end
