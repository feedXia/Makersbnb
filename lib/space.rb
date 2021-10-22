require "pg"
require_relative "database_connection"

class Space
  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id:, name:, description:, price:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price.to_i
    @user_id = user_id
  end

  def self.all
    all_spaces = DatabaseConnection.query("SELECT * FROM spaces;")
    return all_spaces
  end

  def self.add(name:, description:, price:, user_id:)
    query = "INSERT INTO spaces (name, description, price, user_id) VALUES($1, $2, $3, $4);"
    DatabaseConnection.query(query, [name, description, price, user_id])
  end

  def self.find(id:)
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE id=#{id};").map do |space|
      Space.new(
        id: space["id"],
        name: space["name"],
        description: space["description"],
        price: space["price"],
        user_id: space["user_id"],
      )
    end
    return spaces
  end
end
