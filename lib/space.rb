require "pg"
require_relative "database_connection"

class Space
  def self.all
    all_spaces = DatabaseConnection.query("SELECT * FROM spaces;")
    return all_spaces
  end

  def self.add(name:, description:, price:)
    query = "INSERT INTO spaces (name, description, price) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, description, price])
  end

  def self.find(id:)
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE id=#{id};").map do |space|
      Space.new(
        name: space["name"], 
        description: space["description"], 
        price: space["price"], 
        id: space["id"]
      )
    end
    return spaces
  end

  attr_reader :name, :description, :price, :id
  def initialize(name:, description:, price:, id:)
    @name = name
    @id = id
    @description = description
    @price = price.to_i
  end
end
