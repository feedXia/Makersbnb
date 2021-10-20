require 'space'

RSpec.describe Space do
  describe "#all" do
    it 'returns no rows if db is empty' do
      expect(Space.all.values).to eq []
    end

    it 'fetches db data name, description and price and returns it' do
      add_space(name: "Alex House", description: "Spacious and cosy", price: 20)
      add_space(name: "Ewa Mansion", description: "Modern and well-lit", price: 100)
      
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

  describe '#add' do
    it 'adds a new space row to the db' do
      Space.add(name: "Hagrid's Hut", description: "Magical place, close to the nature.", price: 36)
      spaces = show_all_spaces
      
      expect(spaces[0]).to eq({
        name: "Hagrid's Hut", 
        description: "Magical place, close to the nature.", 
        price: '36'
      })
    end
  end
end
