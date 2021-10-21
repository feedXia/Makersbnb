require "pg"
require_relative "database_connection"

class Space
  def self.all
    # connection = Space.connect_db
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    return result
  end

  def self.add(name:, description:, price:, from:, to:)
    # connection = Space.connect_db
    query = "INSERT INTO spaces (name, description, price, from_date, to_date) VALUES($1, $2, $3, $4, $5);"
    DatabaseConnection.query(query, [name, description, price, from, to])
  end

  # def self.connect_db
  #   db_name = ENV["ENVIRONMENT"] == "test" ? "makers_bnb_test" : "makers_bnb"
  #   return PG.connect(dbname: db_name)
  # end

  def self.find(id:)
    # connection = Space.connect_db
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id=#{id};")
    return result
  end

  def self.available(from:, to:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE from_date='#{from}' AND to_date='#{to}';")
    return result
  end
end
