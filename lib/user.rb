require_relative "database_connection"

class User
  attr_reader :id, :name, :email

  def initialize(id:, name:, email:, password:)
    @name = name
    @email = email
    @id = id
    @password = password
  end

  def self.add(name:, email:, password:)
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, email, password])
  end

  def self.login(email:, password:)
    query = "SELECT * FROM users WHERE email = $1;"
    result = DatabaseConnection.query(query, [email])
    return unless result.any?
    user = User.new(
      id: result[0]["id"],
      email: result[0]["email"],
      name: result[0]["name"],
      password: result[0]["password"],
    )
    return user.correct_password?(password) ? user : nil
  end

  def correct_password?(password)
    return @password == password
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(
      id: result[0]["id"],
      email: result[0]["email"],
      name: result[0]["name"],
      password: result[0]["password"],
    )
  end
end
