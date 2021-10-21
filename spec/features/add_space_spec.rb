feature "Adding space" do
  scenario "User can visit page" do
    visit "/spaces/new"
    expect(page.status_code).to eq 200
  end

  scenario "Page displays a header" do
    visit "/spaces/new"
    expect(page).to have_content "List a Space"
  end

  scenario "Page displays a form that user can input onto" do
    visit("/spaces/new")
    fill_in "name", with: "Central apartment"
    fill_in "description", with: "Great apartment in city centre, 2 minute walk from the tube station"
    fill_in "price_night", with: "50"

    click_button "Add Space"
    expect(page).to have_content "Central apartment"
    expect(page).to have_content "Great apartment in city centre, 2 minute walk from the tube station"
    expect(page).to have_content "50"
  end
end
