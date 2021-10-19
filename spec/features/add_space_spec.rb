feature "Adding space" do
  scenario "User can visit page" do
    visit "/spaces/new"
    expect(page.status_code).to eq 200
  end

  scenario "Page displays a header" do
    visit "/spaces/new"
    expect(page).to have_content "List a Space"
  end
end
