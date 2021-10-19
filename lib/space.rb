require 'pg'

class Space
  def self.all
    result = nil
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
      connection.exec("TRUNCATE spaces;")
      connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Alex House', 'Spacious and cosy', 20);")
      connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Ewa Mansion', 'Modern and well-lit', 100);")
      result = connection.exec("SELECT * FROM spaces;")
    else
      connection = PG.connect(dbname: 'makers_bnb')
      result = connection.exec("SELECT * FROM spaces;")
    end
    return result
  end
end
