require "pg"
require_relative "database_connection"

class Space
  attr_reader :name, :description, :price, :id, :from, :to, :user_id

  def initialize(name:, description:, price:, id:, from:, to:, user_id:)
    @name = name
    @id = id
    @description = description
    @price = price.to_i
    @from = from
    @to = to
    @user_id = user_id
  end

  def self.all
    all_spaces = DatabaseConnection.query("SELECT * FROM spaces;")
    return all_spaces
  end

  def self.add(name:, description:, price:, from:, to:)
    query = "INSERT INTO spaces (name, description, price, from_date, to_date) 
            VALUES($1, $2, $3, $4, $5);"
    DatabaseConnection.query(query, [name, description, price, from, to])
  end

  def self.find(id:)
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE id=#{id};")
    return Space.pretify_result(spaces)
  end

  def self.available(from:, to:)
    query = "SELECT * FROM spaces 
              WHERE ($1)::date BETWEEN from_date AND to_date
              AND ($2)::date BETWEEN from_date AND to_date
            ;"
    spaces = DatabaseConnection.query(query, [from, to])
    return Space.pretify_result(spaces)
  end

  def self.pretify_result(spaces)
    return spaces.map do |space|
             Space.new(
               name: space["name"],
               description: space["description"],
               price: space["price"],
               id: space["id"],
               from: space["from_date"],
               to: space["to_date"],
             )
           end
  end
end
