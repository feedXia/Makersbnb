require "pg"

class Space
  def self.all
    connection = Space.connect_db
    result = connection.exec("SELECT * FROM spaces;")
    return result
  end

  def self.add(name:, description:, price:)
    connection = Space.connect_db
    query = "INSERT INTO spaces (name, description, price) VALUES($1, $2, $3);"
    connection.exec(query, [name, description, price])
  end

  def self.connect_db
    db_name = ENV["ENVIRONMENT"] == "test" ? "makers_bnb_test" : "makers_bnb"
    return PG.connect(dbname: db_name)
  end

  def self.find(id:)
    connection = Space.connect_db
    result = connection.exec("SELECT * FROM spaces WHERE id=#{id};")
    return result
  end
end
