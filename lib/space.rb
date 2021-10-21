require "pg"
require_relative "database_connection"
require "sinatra/activerecord"

class Space < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 240 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.all
    # connection = Space.connect_db
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    return result
  end

  def self.add(name:, description:, price:)
    # connection = Space.connect_db
    query = "INSERT INTO spaces (name, description, price) VALUES($1, $2, $3);"
    DatabaseConnection.query(query, [name, description, price])
  end

  # def self.connect_db
  #   db_name = ENV["ENVIRONMENT"] == "test" ? "makers_bnb_test" : "makers_bnb"
  #   return PG.connect(dbname: db_name)
  # end

  # def self.find(id:)
  #   # connection = Space.connect_db
  #   result = DatabaseConnection.query("SELECT * FROM spaces WHERE id=#{id};")
  #   return result
  # end
end
