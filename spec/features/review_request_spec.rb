feature "Review requess" do
  scenario "User can view all requests they have made" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20)
    visit("/spaces")
    click_link "See space details"
    click_link "Request to book"
    expect(page).to have_content "Alex House"
  end
end
