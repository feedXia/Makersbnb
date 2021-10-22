feature "Searching by date range" do
  scenario "User can search properties by date" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20, from: "2021-10-26", to: "2021-10-31")
    visit("/spaces")
    fill_in "user_from", with: "2021-10-26"
    fill_in "user_to", with: "2021-10-31"
    click_button "Search"
    expect(page).to have_content "Alex House"
    expect(page).to have_content "Spacious and cosy"
  end
end
