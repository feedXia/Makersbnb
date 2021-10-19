feature "Adding space" do
  scenario "User can visit page" do
    visit '/spaces/new'
    expect(page.status_code).to eq 200
  end
end