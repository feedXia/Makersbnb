require_relative "database_connection"

class User
  def self.add(name:, email:, password:)
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, email, password])
  end

  def self.login(email:, password:)
    query = "SELECT * FROM users WHERE email = $1;"
    result = DatabaseConnection.query(query, [email])
    p result.values[0]
    user = result.map do |u|
      { "name" => u["name"], "email" => u["email"], "password" => u["password"] }
    end
    return user.length == 1 && result.values[0][3] == password
  end
end
