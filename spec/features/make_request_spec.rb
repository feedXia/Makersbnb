feature "Click button" do
  scenario "User can click buttons" do
    visit("/spaces/new")
    fill_in "name", with: "Central apartment"
    fill_in "description", with: "Great apartment in city centre, 2 minute walk from the tube station"
    fill_in "price_night", with: "50"
    click_button "Add Space"
    click_link "See space details"
    click_link "Request to book"
    expect(page).to have_content "Your request has been sent"
  end
end
