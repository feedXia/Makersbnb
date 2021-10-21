feature "Searching by date range" do
  scenario "User can search properties by date" do
    visit("/spaces/new")
    fill_in "name", with: "Central apartment"
    fill_in "description", with: "Great apartment in city centre, 2 minute walk from the tube station"
    fill_in "price_night", with: "50"
    fill_in "from", with: "2021-10-01"
    fill_in "to", with: "2021-10-03"
    click_button "Add Space"
    visit("/spaces")
    fill_in "user_from", with: "2021-10-01"
    fill_in "user_to", with: "2021-10-03"
    click_button "Search"
    visit "/spaces/search"
    expect(page).to have_content "Central apartment"
    expect(page).to have_content "Great apartment in city centre, 2 minute walk from the tube station"
  end
end
