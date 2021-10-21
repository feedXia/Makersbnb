feature "Searching by date range" do
  scenario "User can visit page" do
    visit "/spaces/search"
    expect(page.status_code).to eq 200
  end

feature "Page displays spaces available" do
  scenario "User can search properties by date" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20, from: "2021-10-01", to: "2021-10-03")
    visit("/spaces")
    fill_in "user_from", with: "2021-10-01"
    fill_in "user_to", with: "2021-10-03"
    click_button "Search"
    visit "/spaces/search"
    expect(page).to have_content "Central apartment"  
  end
end