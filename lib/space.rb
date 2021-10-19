class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'spaces_test')
      connection.exec("TRUNCATE spaces;")
      connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Alex House', 'Spacious and cosy', 20);")
    end
  
    result = connection.exec("SELECT * FROM spaces;")
  end
end
