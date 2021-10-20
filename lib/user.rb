class User
  def self.add(name:, email:, password:)
    connection = User.connect_db
    query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
    connection.exec(query, [name, email, password])
  end

  def self.connect_db
    db_name = ENV["ENVIRONMENT"] == "test" ? "makers_bnb_test" : "makers_bnb"
    return PG.connect(dbname: db_name)
  end
end
