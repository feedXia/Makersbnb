require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get "/spaces" do
    connection = PG.connect(dbname: 'spaces_test')
    connection.exec("TRUNCATE spaces;")
    connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Alex House', 'Spacious and cosy', 20);")

    @result = connection.exec('SELECT * FROM spaces')
    erb :spaces
  end

  run! if app_file == $0
end
