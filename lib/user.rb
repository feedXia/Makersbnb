require_relative "database_connection"

class User
  def self.add(name:, email:, password:)
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, email, password])
  end
end
