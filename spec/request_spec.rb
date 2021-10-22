require "request"

RSpec.describe Request do
  describe "#add" do
    context "given a user_id & space_id" do
      it "returns result_id (id), user_id & space_id" do
        add_space(name: "Cosy Castle Byers", description: "Rustic treehouse in the woods", price: 90, from: "2021-10-26", to: "2021-10-31")
        User.add(name: "Eleven", email: "el@strangerthings.com", password: "Mouthbreather")
        puts "spaces"
        spaces = Space.all
        users = User.all
        request = Request.add(user_id: users[0].id, space_id: spaces[0]["id"])
        expect(request.id).to be_an(Integer)
        expect(request.user_id).to be_an(Integer)
        expect(request.space_id).to be_an(Integer)
      end
    end
  end

  describe "#by_user" do
    context "given an user_id" do
      it "returns an array with all the requests made by the user" do
        add_space(name: "Cosy Castle Byers", description: "Rustic treehouse in the woods", price: 90, from: "2021-10-26", to: "2021-10-31")
        add_space(name: "Cosy Hawkins Lab", description: "A perfectly normal laboratory that's definitely not a portal to another dimention. Set in the town of Hawkins where nothing ever happens.", price: 90)
        User.add(name: "Eleven", email: "el@strangerthings.com", password: "Mouthbreather")
        spaces = Space.all
        users = User.all
        request1 = Request.add(user_id: users[0].id, space_id: spaces[0]["id"])
        request2 = Request.add(user_id: users[0].id, space_id: spaces[1]["id"])
        Request.by_user(user_id: request1.user_id)
      end
    end
  end
end
