require 'space'

RSpec.describe Space do
  describe ".all" do
    it 'fetches db data name, description and price and returns it' do
      Space.add(name: "Alex House", description: "Spacious and cosy", price: 20)
      Space.add(name: "Ewa Mansion", description: "Modern and well-lit", price: 100)
      results = Space.all
      result1 = results.values[0]  # arr of the data point
      result2 = results.values[1] 
      expect(result1).to include("Alex House")
      expect(result1).to include("Spacious and cosy")
      expect(result1).to include("20")
      expect(result2).to include("Ewa Mansion")
      expect(result2).to include("Modern and well-lit")
      expect(result2).to include("100")
    end
  end
end
