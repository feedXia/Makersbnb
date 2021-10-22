feature "Review request" do
  scenario "User can view all requests they have made" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20, from: "2021-10-26", to: "2021-10-31")
    visit("/spaces")
    click_link "See space details"
    click_button "Request to book"
    expect(page).to have_content "Alex House"
  end
end
