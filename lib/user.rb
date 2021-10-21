require_relative "database_connection"

class User
  def self.add(name:, email:, password:)
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, email, password])
  end

  def self.login(email:, password:)
    query = "SELECT * FROM users WHERE email = $1;"
    result = DatabaseConnection.query(query, [email])
    users = result.map do |user|
      User.new(name: user["name"], email: user["email"], password: user["password"], id: user["id"])
    end
    return users.length == 1 && users[0].correct_password?(password)
  end

  attr_reader :name, :email, :id
  def initialize(name:, email:, id:, password:) 
    @name = name
    @email = email
    @id = id
    @password = password
  end

  def correct_password?(password)
    return @password == password
  end
end
