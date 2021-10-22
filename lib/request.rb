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
      id: result[0]["id"].to_i,
      user_id: result[0]["user_id"].to_i,
      space_id: result[0]["space_id"].to_i,
    )
  end

  def self.by_user(user_id:)
    user_requests = DatabaseConnection.query("SELECT * FROM requests WHERE user_id = '#{user_id}';")
    user_requests.map do |request|
      Request.new(
        id: request["id"],
        user_id: request["user_id"],
        space_id: request["space_id"],
      )
    end
  end
end
