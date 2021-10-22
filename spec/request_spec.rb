require "request"

RSpec.describe Request do
  describe "#add" do
    context "given a user_id & space_id" do
      it "returns result_id (id), user_id & space_id" do
        add_space(name: "Cosy Byers Castle", description: "Rustic treehouse in the woods", price: 90)
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
end
