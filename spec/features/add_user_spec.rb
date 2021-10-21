feature "Adding user" do
  scenario "Registration page exists" do
    visit "/user/new"
    expect(page.status_code).to eq 200
  end

  scenario "Page displays a header" do
    visit "/user/new"
    expect(page).to have_content "Registration"
  end

  scenario "Page displays a form that user can input onto" do
    visit("/user/new")
    fill_in "name", with: "Hermione Granger"
    fill_in "email", with: "hermione@example.com"
    fill_in "password", with: "bookworm"
    click_button "Sign Up"
    expect(page).to have_content "Hermione Granger, thank you for registration!"
  end

  scenario "Page displays a form that user can input onto" do
    visit("/user/new")
    fill_in "name", with: "Hermione Granger"
    fill_in "email", with: "hermione@example.com"
    fill_in "password", with: "bookworm"
    click_button "Sign Up"

    all_users = show_all_users

    expect(all_users).to include({ name: "Hermione Granger", email: "hermione@example.com" })
  end
end
