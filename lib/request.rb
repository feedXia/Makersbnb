require "pg"
require_relative "database_connection"

class Request
  attr_reader :id, :user_id, :space_id

  def initialize(id:, user_id:, space_id:)
    @id = id
    @user_id = user_id
    @space_id = space_id
  end

  def self.add(user_id:, space_id:)
    query = "INSERT INTO requests (user_id, space_id)
    VALUES ($1, $2)
    RETURNING id, user_id, space_id;"
    result = DatabaseConnection.query(query, [user_id, space_id])
    Request.new(
      id: result[0]["id"],
      user_id: result[0]["user_id"],
      space_id: result[0]["space_id"],
    )
  end

  def self.by_user(user_id:)
    query = "SELECT requests.id, requests.space_id, requests.user_id FROM requests
    JOIN spaces ON (spaces.id=space_id) JOIN users
    ON (spaces.user_id=users.id) WHERE users.id= $1;"
    result = DatabaseConnection.query(query, [user_id])
    result.map do |request|
      Request.new(
        id: request["id"],
        user_id: request["user_id"],
        space_id: request["space_id"],
      )
    end
  end
end
