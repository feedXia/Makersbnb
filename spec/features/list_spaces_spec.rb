require "pg"

feature "It displays spaces" do
  scenario "a guest can view all spaces in a single page" do
    add_space(name: "Alex House", description: "Spacious and cosy", price: 20)
    add_space(name: "Ewa Mansion", description: "Modern and well-lit", price: 100)

    visit "/spaces"
    expect(page).to have_content "Alex House"
    expect(page).to have_content "Spacious and cosy"
    expect(page).to have_content "20"
    expect(page).to have_content "Ewa Mansion"
    expect(page).to have_content "Modern and well-lit"
    expect(page).to have_content "100"
  end
end
