require "user"
describe User do
  describe "#all" do
    it "returns the user's id, name & email" do
      User.add(name: "Eleven", email: "el@strangerthings.com", password: "Mouthbreather")
      User.add(name: "Dart", email: "dart@strangerthings.com", password: "Nougat")
      users = User.all
      expect(users[0].id).to be_an(Integer)
      expect(users[0].name).to eq "Eleven"
      expect(users[0].email).to eq "el@strangerthings.com"
    end
  end
  describe "#add" do
    it "Adds a new user to the DB" do
      User.add(name: "Hermione", email: "hermi@example.com", password: "bookworm")
      all_users = show_all_users
      expect(all_users[0]).to eq({ name: "Hermione", email: "hermi@example.com" })
    end
  end

  describe "#login" do
    it "Logs the user in" do
      User.add(name: "Hermione", email: "hermi@example.com", password: "bookworm")
      expect(User.login(email: "hermi@example.com", password: "bookworm")).to be_instance_of User
    end

    it "doesn't login if password is wrong" do
      User.add(name: "Hermione", email: "hermi@example.com", password: "bookworm")
      expect(User.login(email: "hermi@example.com", password: "books")).to eq nil
    end

    it "doesn't login if email not in the DB" do
      expect(User.login(email: "hermi@example.com", password: "bookworm")).to eq nil
    end
  end

  describe '#find' do
    it 'returns the user' do
      user = User.add(name: "Hermione", email: "hermi@example.com", password: "bookworm")

      result = User.find(id: user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end

end
