require "space"

RSpec.describe Space do
  describe "#all" do
    it "returns no rows if db is empty" do
      expect(Space.all.values).to eq []
    end

    it "fetches db data name, description and price and returns it" do
      add_space(name: "Alex House", description: "Spacious and cosy", price: 20, from: "2021-10-26", to: "2021-10-31")
      add_space(name: "Ewa Mansion", description: "Modern and well-lit", price: 100, from: "2021-10-26", to: "2021-10-31")

      results = Space.all
      result1 = results.values[0] # arr of the data point
      result2 = results.values[1]

      expect(result1).to include("Alex House")
      expect(result1).to include("Spacious and cosy")
      expect(result1).to include("20")

      expect(result2).to include("Ewa Mansion")
      expect(result2).to include("Modern and well-lit")
      expect(result2).to include("100")
    end
  end

  describe "#add" do
    it "adds a new space row to the db" do
      add_space(name: "Hagrid's Hut", description: "Magical place, close to the nature.", price: 36, from: "2021-10-26", to: "2021-10-31")
      spaces = show_all_spaces

      expect(spaces[0]).to eq({
        name: "Hagrid's Hut",
        description: "Magical place, close to the nature.",
        price: "36",
      })
    end
  end

  describe "#find" do
    it "returns property details by id" do
      connection = PG.connect(dbname: "makers_bnb_test")
      query = "INSERT INTO spaces (id, name, description, price, from_date, to_date) VALUES($1, $2, $3, $4, $5, $6);"
      page_id = connection.exec(query, [1, "Hagrid's Hut", "Magical place, close to the nature.", 36, "2021-10-14", "2021-11-01"])
      expect(Space.find(id: 1)[0].id).to eq Space.all[0]["id"]
    end
  end

  describe "#available" do
    it "returns available spaces by dates, same range" do
      add_space(name: "Hagrid's Hut", description: "Magical place, close to the nature.", price: 36, from: "2021-10-01", to: "2021-10-03")
      result = Space.available(from: "2021-10-01", to: "2021-10-03")
      expect(result[0].description).to eq "Magical place, close to the nature."
    end

    it "returns available spaces by date in range" do
      add_space(name: "Hagrid's Hut", description: "Magical place, close to the nature.", price: 36, from: "2021-10-01", to: "2021-12-03")
      result = Space.available(from: "2021-10-01", to: "2021-10-03")
      expect(result[0].description).to eq "Magical place, close to the nature."
    end
  end
end
