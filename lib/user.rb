require_relative "database_connection"

class User
  def self.add(name:, email:, password:)
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, email, password])
  end

  def self.login(email:, password:)
    query = "SELECT * FROM users WHERE email = $1;"
    result = DatabaseConnection.query(query, [email])
    # p result.values[0]
    users = result.map do |user|
      { "name" => user["name"], "email" => user["email"], "password" => user["password"] }
    end
    return users.length == 1 && users[0]["password"] == password
  end
end
