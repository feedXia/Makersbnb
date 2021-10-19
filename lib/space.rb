require 'pg'

class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'spaces_test')
      connection.exec("TRUNCATE spaces;")
      connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Alex House', 'Spacious and cosy', 20);")
      connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Ewa Mansion', 'Modern and well-lit', 100);")
      result = connection.exec("SELECT * FROM spaces;")
      return result
    else
      connection = PG.connect(dbname: 'spaces')
      result = connection.exec("SELECT * FROM spaces;")
      return result
    end
  end
end
