require "pg"

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("TRUNCATE spaces, users;")
end

def show_all_spaces
  connection = PG.connect(dbname: "makers_bnb_test")
  result = connection.exec("SELECT * FROM spaces;").map do |space|
    {
      description: space["description"],
      name: space["name"],
      price: space["price"],
    }
  end
  return result
end

def add_space(name:, description:, price:, from:, to:)
  connection = PG.connect(dbname: "makers_bnb_test")
  query = "INSERT INTO spaces (name, description, price, from_date, to_date) VALUES($1, $2, $3, $4, $5);"
  connection.exec(query, [name, description, price, from, to])
end

def show_all_users
  connection = PG.connect(dbname: 'makers_bnb_test')
  result = connection.exec("SELECT * FROM users;").map do |user|
    {
      name: user["name"],
      email: user["email"]
    }
  end
  return result
end

# def add_user(name:, email:, password:)
#   connection = PG.connect(dbname: "makers_bnb_test")
#   query = "INSERT INTO users (name, email, password) VALUES($1, $2, $3);"
#   connection.exec(query, [name, email, password])
# end
