require 'space'

RSpec.describe Space do
  describe ".all" do
    it 'fetches db data name, description and price and returns it' do
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
