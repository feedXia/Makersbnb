require 'space'

RSpec.describe Space do
  describe ".all" do
    it 'fetches db data name, description and price and returns it' do
      result = Space.all
      result = result.values[0]  # arr of the data point
      expect(result).to include("Alex House")
      expect(result).to include("Spacious and cosy")
      expect(result).to include("20")
    end
  end
end
