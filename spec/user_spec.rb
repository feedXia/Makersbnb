require "user"
describe User do
  describe "#add" do
    it "Adds a new user to the DB" do
      User.add(name: "Hermione", email: "hermi@example.com", password: "bookworm")
      all_users = show_all_users
      expect(all_users[0]).to eq({ name: "Hermione", email: "hermi@example.com" })
    end
  end
end
