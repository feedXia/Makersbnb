feature "Request to book" do
  scenario "User can click button and be taken to the Requests page" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20)
    visit("/spaces")
    click_link "See space details"
    click_link "Request to book"
    expect(page).to have_content "Requests"
  end
end
