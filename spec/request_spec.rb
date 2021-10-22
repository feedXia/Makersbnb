require "request"

RSpec.describe Request do
  describe "#add" do
    context "given a user_id & space_id" do
      it "returns result_id (id), user_id & space_id" do
        add_space(name: "Cosy Byers Castle", description: "Rustic treehouse in the woods", price: 90)
        User.add(name: "Eleven", email: "el@strangerthings.com", password: "Mouthbreather")
        p spaces = Space.all
        p users = User.all
        p Request.add(user_id: users.id)
      end
    end
  end
end
